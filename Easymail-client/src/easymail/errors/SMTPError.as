package easymail.errors {
    public class SMTPError extends Error {
        public function SMTPError(message:* = "") {
            super(message);
        }
    }
}