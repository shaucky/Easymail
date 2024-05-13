package easymail.smtp {
    /**
     * The SMTPLine class is used to store reply lines from the SMTP server.
     * @playerversion AIR 51.0
     */
    public class SMTPLine {
        private var _replyCode:int;
        private var _content:String;
        /**
         * Return the reply code of this line.
         */
        public function get replyCode():int {
            return _replyCode;
        }
        /**
         * Return the content of this line.
         */
        public function get content():String {
            return _content;
        }
        
        public function SMTPLine(replyCode:int, content:String) {
            _replyCode = replyCode;
            _content = content;
        }
    }
}