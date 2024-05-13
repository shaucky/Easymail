package easymail.core {
    public class Transporter {
        public function send(connection:IConnection, message:MailMessage, user:String, password:String):void {
            if (message.addresses == null || message.addresses.length == 0) {
                throw(new Error());
            }
            
        }
    }
}