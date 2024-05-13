package easymail.events {
    import easymail.smtp.SMTPLine;
    import flash.events.Event;

    /**
     * The application dispatches SMTPEvent objects when SMTPConnection interacting.
     */
    public class SMTPEvent extends Event {
        public static const QUIT:String = "quit";
        public static const REPLY:String = "reply";

        public function SMTPEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, lines:Vector.<SMTPLine> = null) {
            super(type, bubbles, cancelable);
        }
    }
}