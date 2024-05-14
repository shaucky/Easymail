/**
 * This package contains classes related to SMTP connections. The implementation of SMTP in the Easymail library is based on RFC 5321 and RFC 4954.
 */
package easymail.smtp {
    import easymail.core.Connection;
    import easymail.errors.SMTPError;
    import easymail.events.SMTPEvent;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.utils.ByteArray;

    /**
     * Dispatched when command QUIT is sent.
     */
    [Event(name="quit", type="easymail.events.SMTPEvent")]
    /**
     * Dispatched when received reply from server.
     */
    [Event(name="reply", type="easymail.events.SMTPEvent")]
    /**
     * The SMTPConnection class is used for basic email sending.
     * <p>The SMTPConnection class is implemented based on RFC 4954 and RFC 5321, but it may be limited by the AIR APIs in some aspects.</p>
     * <p>Once the STMPConnection object is connected to the target SMTP server, an EHLO command will be sent to the target server to enable developers to quickly obtain the server's SMTP service extension.</p>
     * @playerversion AIR 51.0
     * @see www.rfc-editor.org/rfc/rfc4954 RFC 4954 (SMTP Service Extension for Authentication)
     * @see www.rfc-editor.org/rfc/rfc5321 RFC 5321 (Simple Mail Transfer Protocol)
     */
    public class SMTPConnection extends Connection {
        private static const _SYNTAX_ERROR:String = "Arguments or syntax not accepted.";
        private static const _UTF8:String = "utf-8";
        private var _base64Encoder:ByteArray = new ByteArray();
        /**
         * @private
         */
        protected var _lastReceived:Vector.<SMTPLine>;
        /**
         * Returns the last reply line received from the server. It may be multi lines.
         */
        public function get lastReceived():Vector.<SMTPLine> {
            return _lastReceived;
        }

        public function SMTPConnection(host:String, port:int = 25) {
            super();
            _host = host;
            _port = port;
        }
        /**
         * Enable the SMTPConnection object to start connecting to the target SMTP server.
         * <p>According to RFC 5321, EHLO is the default HELLO command. Therefore, when the SMTPConnection successfully connects to the SMTP server, the sendEHLO() method will be automatically executed once.</p>
         */
        public override function connect():void {
            addEventListener(Event.CONNECT, _onConnect);
            addEventListener(ProgressEvent.SOCKET_DATA, _onSocketData);
            addEventListener(Event.CLOSE, _onClose);
            super.connect();
        }
        private function _onConnect(e:Event):void {
            removeEventListener(Event.CONNECT, _onConnect);
            sendEHLO();
        }
        private function _onSocketData(e:ProgressEvent):void {
            var lastLines:Vector.<SMTPLine> = new Vector.<SMTPLine>();
            var lines:Array;
            var response:String = _socket.readUTFBytes(_socket.bytesAvailable);
            lines = response.split("\r\n");
            for each (var line:String in lines) {
                trace(line);
                if (line.length > 3) {
                    lastLines.push(new SMTPLine(int(line.substr(0, 3)), line.substr(4)));
                } else if (line.length == 3) {
                    lastLines.push(new SMTPLine(int(line.substr(0, 3)), ""));
                }
            }
            _lastReceived = lastLines;
            dispatchEvent(new SMTPEvent(SMTPEvent.REPLY, false, false, lastLines));
        }
        private function _onClose(e:Event):void {
            removeEventListener(Event.CONNECT, _onConnect);
            removeEventListener(ProgressEvent.SOCKET_DATA, _onSocketData);
            removeEventListener(Event.CLOSE, _onClose);
        }
        /**
         * Send EHLO command.
         * <p>According to RFC 5321, EHLO is the default HELLO command. Therefore, once the SMTPConnection object successfully connects to the SMTP server, this method will be automatically executed once.</p>
         * <p>Before executing this method, the localHostName property should be set.</p>
         * @see #sendRSET() sendRSET()
         */
        public function sendEHLO():void {
            if (_localHostName.match(SMTPSyntax.DOMAIN) || _localHostName.match(SMTPSyntax.ADDRESS_LITERAL)) {
                _sendCommand("EHLO " + _localHostName);
            } else {
                throw(new SMTPError(_SYNTAX_ERROR));
            }
        }
        /**
         * Send HELO command.
         * <p>According to RFC 5321, HELO is an old version of the HELLO command for SMTP. Modern SMTP clients should send EHLO instead of HELO. This method is provided for forward compatibility.</p>
         * <p>Before executing this method, the localHostName property should be set.</p>
         * @see #sendEHLO() sendEHLO()
         */
        public function sendHELO():void {
            if (_localHostName.match(SMTPSyntax.DOMAIN)) {
                _sendCommand("HELO " + _localHostName);
            } else {
                throw(new SMTPError(_SYNTAX_ERROR));
            }
        }
        /**
         * Send MAIL FROM command.
         * @param sender the address of sender.
         */
        public function sendMAILFROM(sender:String):void {
            if (sender.match(SMTPSyntax.REVERSE_PATH)) {
                _sendCommand("MAIL FROM:<" + sender + ">");
            } else {
                throw(new SMTPError(_SYNTAX_ERROR));
            }
        }
        /**
         * Send RCPT TO command.
         * <p>Each RCPT TO command specifies one recipient.</p>
         * @param recipient the address of recipient.
         * @param sourceRoute the source route of address. According to RFC 5321, this parameter is abandoned.
         */
        public function sendRCPTTO(recipient:String, sourceRoute:String = null):void {
            var cmd:String;
            if (sourceRoute) {
                if (sourceRoute.match(SMTPSyntax.A_D_L) && recipient.match(SMTPSyntax.FORWARD_PATH)) {
                    cmd = "RCPT TO:<" + sourceRoute + ":" + recipient + ">";
                } else {
                    throw(new SMTPError(_SYNTAX_ERROR));
                }
            } else {
                if (recipient.match(SMTPSyntax.FORWARD_PATH)) {
                    cmd = "RCPT TO:<" + recipient + ">";
                } else {
                    throw(new SMTPError(_SYNTAX_ERROR));
                }
            }
            _sendCommand(cmd);
        }
        /**
         * Send DATA command.
         * <p>The DATA command and mail message are sent asynchronously. After sending the DATA command, received a 354 reply code from SMTP server, and then send mail message.</p>
         * @see #sendMailMessage() sendMailMessage()
         */
        public function sendDATA():void {
            _sendCommand("DATA");
        }
        /**
         * Send mail message.
         * <p>The DATA command and mail message are sent asynchronously. Before sending the mail message, should send a DATA command, and SMTP will feed back a 354 reply code.</p>
         * @param sender the address of sender.
         * @param recipient the address of recipient.
         * @param title the title of the mail.
         * @param data the content of the mail.
         * @see #sendDATA() sendDATA()
         */
        public function sendMailMessage(sender:String, recipient:String, title:String, data:String, contentType:String):void {
            data = data.replace(/(^\.\s*)/gm, "..$1");
            _sendCommand("Subject: " + title + "\r\nFrom: " + sender + "\r\nTo: " + recipient + "\r\nContent-Type: " + contentType + "\r\n\r\n" + data + "\r\n.");
        }
        /**
         * Send RSET command.
         * <p>If wanting to reset the SMTP communication status, please send RSET instead of EHLO. Even if the formal semantics are the same, EHLO may cause the server to perform more behavior.</p>
         */
        public function sendRSET():void {
            _sendCommand("RSET");
        }
        /**
         * Send NOOP command.
         * <p>NOOP does not cause any behavior, and more commonly, it is used as a heartbeat packet to maintain connection.</p>
         */
        public function sendNOOP():void {
            _sendCommand("NOOP");
        }
        /**
         * Send QUIT command.
         * <p>Notify the SMTP server to disconnect. Usually, after issuing this command, the local connection should be disconnected.</p>
         */
        public function sendQUIT():void {
            _sendCommand("QUIT");
            dispatchEvent(new SMTPEvent(SMTPEvent.QUIT));
            removeEventListener(Event.CONNECT, _onConnect);
            removeEventListener(ProgressEvent.SOCKET_DATA, _onSocketData);
            removeEventListener(Event.CLOSE, _onClose);
            _socket.close();
        }
        /**
         * Send VRFY command.
         * <p>Require the SMTP server to verify whether the incoming parameter is an address.</p>
         * @param string the parameter which need be verified.
         */
        public function sendVRFY(string:String):void {
            if (string.match(SMTPSyntax.STRING)) {
                _sendCommand("VRFY" + string);
            } else {
                throw(new SMTPError(SyntaxError));
            }
        }
        /**
         * Send HELP command.
         * <p>Ask the SMTP server to send helpful information for a command.</p>
         * @param command the command name which need helpful information from server.
         */
        public function sendHELP(command:String):void {
            if (command.match(SMTPSyntax.STRING)) {
                _sendCommand("HELP " + command);
            }
        }
        /**
         * Send AUTH command.
         * <p>This command is used for authentication to the SMTP server. Before send AUTH, EHLO should be sent to the server to confirm if the server supports the AUTO extension.</p>
         * @param mechanism the method for authentication.
         * @param initialResponse initial response if needed.
         * @see #sendEHLO() sendEHLO()
         */
        public function sendAUTH(mechanism:String, initialResponse:String = null):void {
            if (mechanism.match(SMTPSyntax.SASL_MECH)) {
                if (initialResponse) {
                    if (initialResponse.match(SMTPSyntax.INITIAL_RESPONSE)) {
                        initialResponse = _toBase64(initialResponse);
                    } else {
                        throw(new SMTPError(_SYNTAX_ERROR));
                    }
                    _sendCommand("AUTH " + mechanism + " " + initialResponse);
                } else {
                    _sendCommand("AUTH " + mechanism);
                }
            }
        }
        /**
         * Send a response in base64 encoding.
         * <p>Some responses need be in base64 encoding, such as username and password for AUTH LOGIN.</p>
         * @param string response which need be in base64 encoding.
         */
        public function sendBase64(string:String):void {
            var str:String = _toBase64(string);
            if (str.match(SMTPSyntax.BASE64)) {
                _sendCommand(_toBase64(string));
            } else {
                throw(new SMTPError(_SYNTAX_ERROR));
            }
        }
        /**
         * @private
         */
        protected function _sendCommand(command:String):void {
            _socket.writeUTFBytes(command + "\r\n");
            trace(command + "\r\n");
            _socket.flush();
        }
        /**
         * @private
         */
        private function _toBase64(string:String):String {
            var str:String;
            _base64Encoder.clear();
            _base64Encoder.writeMultiByte(string, _UTF8);
            str = _base64Encoder.toBase64();
            _base64Encoder.clear();
            return str;
        }
        /**
         * Decode a string from Base64 encoding.
         * @param string content needed decode.
         */
        public function fromBase64(string:String):String {
            var str:String;
            _base64Encoder.clear();
            _base64Encoder.writeBase64(string);
            str = _base64Encoder.toString();
            _base64Encoder.clear();
            return str;
        }
    }
}