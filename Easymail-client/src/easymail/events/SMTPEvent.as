package easymail.events {
    import easymail.smtp.SMTPLine;
    import flash.events.Event;

    /**
     * The application dispatches SMTPEvent objects when SMTPConnection interacting.
     */
    public class SMTPEvent extends Event {
        public static const QUIT:String = "quit";
        public static const REPLY:String = "reply";
        private var _lines:Vector.<SMTPLine>;
        public function get lines():Vector.<SMTPLine> {
            return _lines;
        }

        public function SMTPEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, lines:Vector.<SMTPLine> = null) {
            super(type, bubbles, cancelable);
            _lines = lines;
        }
    }
}