package easymail.core {
    import flash.utils.ByteArray;

    /**
     * MailMessage contains the message for send.
     * <p></p>
     * @playerversion AIR 51.0
     */
    public class MailMessage {
        /**
         * @private
         */
        protected const _addresses:Vector.<String> = new Vector.<String>();
        /**
         * @private
         */
        protected const _content:ByteArray = new ByteArray();
        private var _type:String;
        private const _UTF8:String = "utf-8";
        public function get addresses():Vector.<String> {
            return _addresses;
        }
        /**
         * The content of MailMessage object. Using UTF-8 encoding.
         */
        public function get content():String {
            var str:String;
            str = _content.readMultiByte(_content.length, _UTF8);
            return str;
        }
        public function set content(value:String):void {
            _content.clear();
            _content.writeMultiByte(value, _UTF8);
        }
        /**
         * Define the type of email content.
         * <p>The acceptable values include "html" and "plain", which respectively correspond to MIME types "text/html" and "text/plain".</p>
         */
        public function get type():String {
            return _type;
        }
        public function set type(value:String):void {
            switch (value) {
                case "html":
                case "plain":
                    _type = value;
                    break;
            }
        }

        public function MailMessage(...args) {
            //
        }
    }
}