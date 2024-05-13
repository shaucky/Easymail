package easymail.core {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.Socket;

    /**
     * Dispatched when the Connection object connected.
     */
    [Event(name="connect", type="flash.events.Event")]
    /**
     * Dispatched when the Connection has received data.
     */
    [Event(name="socketData", type="flash.events.ProgressEvent")]
    /**
     * Dispatched when an input/output error occurs that causes a send or load operation to fail.
     */
    [Event(name="ioError", type="flash.events.IOErrorEvent")]
    /**
     * Dispatched when the Connection is closed.
     */
    [Event(name="close", type="flash.events.Event")]
    /**
     * The Connection class is the base class for various protocol connection class in Easymail library.
     * @playerversion AIR 51.0
     */
    public class Connection extends EventDispatcher implements IConnection {
        /**
         * @private
         */
        protected var _host:String;
        /**
         * @private
         */
        protected var _localHostName:String;
        /**
         * @private
         */
        protected var _port:int;
        /**
         * @private
         */
        protected var _socket:Socket;

        /**
         * Return the status of Connection. Return true if the connection is maintaining.
         */
        public function get isConnected():Boolean {
            return _socket.connected;
        }
        /**
         * The local host name. Usually be the domain name.
         */
        public function get localHostName():String {
            return _localHostName;
        }
        public function set localHostName(value:String):void {
            _localHostName = value;
        }

        public function Connection() {
            _socket = new Socket();
        }
        
        /**
         * Attemp to establish a connection. if the Connection is closed, should construct a new Connection object to connect server.
         */
        public function connect():void {
            _socket.addEventListener(Event.CONNECT, _onSocketConnected);
            _socket.connect(_host, _port);
        }
        /**
         * Disconnect the current connection.
         */
        public function close():void {
            _socket.removeEventListener(Event.CONNECT, _onSocketConnected);
            _socket.removeEventListener(ProgressEvent.SOCKET_DATA, _onSocketData);
            _socket.removeEventListener(IOErrorEvent.IO_ERROR, _onIOError);
            _socket.removeEventListener(Event.CLOSE, _onSocketClosed);
            _socket.close();
        }

        private function _onSocketConnected(e:Event):void {
            e.target.removeEventListener(Event.CONNECT, _onSocketConnected);
            e.target.addEventListener(ProgressEvent.SOCKET_DATA, _onSocketData);
            e.target.addEventListener(IOErrorEvent.IO_ERROR, _onIOError);
            e.target.addEventListener(Event.CLOSE, _onSocketClosed);
            dispatchEvent(new Event(Event.CONNECT));
        }
        private function _onSocketData(e:ProgressEvent):void {
            dispatchEvent(new ProgressEvent(ProgressEvent.SOCKET_DATA, false, false, e.bytesLoaded));
        }
        private function _onIOError(e:IOErrorEvent):void {
            dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, e.text, e.errorID));
        }
        private function _onSocketClosed(e:Event):void {
            e.target.removeEventListener(ProgressEvent.SOCKET_DATA, _onSocketData);
            e.target.removeEventListener(IOErrorEvent.IO_ERROR, _onIOError);
            e.target.removeEventListener(Event.CLOSE, _onSocketClosed);
            dispatchEvent(new Event(Event.CLOSE));
        }
    }
}