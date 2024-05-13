package easymail.core {
    import flash.events.IEventDispatcher;

    public interface IConnection extends IEventDispatcher {
        function connect():void;
        function get isConnected():Boolean;
        function get localHostName():String;
        function set localHostName(value:String):void;
    }
}