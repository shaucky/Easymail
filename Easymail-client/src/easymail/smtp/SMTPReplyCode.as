package easymail.smtp {
    /**
     * The SMTPReplyCode class provides constant values for reply codes as specified in RFC 5321 and RFC 4954.
     * <p>For query or output the corresponding description of the reply code, the searchByCode() method can be used to query.</p>
     * @playerversion AIR 51.0
     */
    public class SMTPReplyCode {
        /**
         * System status, or system help reply.
         */
        public static const SYSTEM_STATUS_REPLY:int = 211;
        /**
         * Help message.
         * (Information on how to use the receiver or the meaning of a particular non-standard command; this reply is useful only to the human user)
         */
        public static const HELP_MESSAGE:int = 214;
        /**
         * &lt;domain&gt; Service ready.
         */
        public static const SERVICE_READY:int = 220;
        /**
         * &lt;domain&gt; Service closing transmission channel.
         */
        public static const SERVICE_CLOSING_CHANNAL:int = 221;
        /**
         * Requested mail action okay, completed.
         */
        public static const ACTION_COMPLETED:int = 250;
        /**
         * User not local; will forward to &lt;forward-path&gt;.
         */
        public static const USER_NOT_LOCAL:int = 251;
        /**
         * Cannot VRFY user, but will accept message and attempt delivery.
         */
        public static const CANNOT_VRFY_USER:int = 252;
        /**
         * 
         */
        public static const CONTINUE_REQUEST:int = 334;
        /**
         * Start mail input; end with &lt;CRLF&gt;.&lt;CRLF&gt;.
         */
        public static const START_MAIL_INPUT:int = 354;
        /**
         * &lt;domain&gt; Service not available, closing transmission channel.
         * (This may be a reply to any command if the service knows it must shut down)
         */
        public static const SERVICE_NOT_AVAILABLE:int = 421;
        /**
         * Requested mail action not taken: mailbox unavailable (e.g., mailbox busy).
         */
        public static const MAILBOX_UNAVAILABLE:int = 450;
        /**
         * Requested action aborted: local error in processing.
         */
        public static const LOCAL_ERROR:int = 451;
        /**
         * Requested action not taken: insufficient system storage.
         */
        public static const INSUFFICIENT_SYSTEM_STORAGE:int = 452;
        /**
         * Server unable to accommodate parameters.
         */
        public static const UNABLE_TO_ACCOMMODATE:int = 455;
        /**
         * Syntax error, command unrecognized.
         * (This may include errors such as command line too long)
         */
        public static const SYNTAX_ERROR:int =  500;
        /**
         * Syntax error in parameters or arguments.
         */
        public static const SYNTAX_ERROR_IN_PARAMETERS_OR_ARGUMENTS:int = 501;
        /**
         * Command not implemented.
         */
        public static const COMMAND_NOT_IMPLEMENTED:int = 502;
        /**
         * Bad sequence of commands.
         */
        public static const BAD_SEQUENCE_OF_COMMANDS:int = 503;
        /**
         * Command parameter not implemented.
         */
        public static const COMMAND_PARAMETERS_NOT_IMPLEMENTED:int = 504;
        /**
         * Requested action not taken: mailbox unavailable.
         * (e.g., mailbox not found, no access, or command rejected for policy reasons)
         */
        public static const MAILBOX_UNAVAILABLE_SERIOUS:int = 550;
        /**
         * User not local; please try &lt;forward-path&gt;.
         */
        public static const USER_NOT_LOCAL_SERIOUS:int = 551;
        /**
         * Requested mail action aborted: exceeded storage allocation.
         */
        public static const EXCEEDED_STORAGE_ALLOCATION:int = 552;
        /**
         * Requested action not taken: mailbox name not allowed.
         * (e.g., mailbox syntax incorrect)
         */
        public static const MAILBOX_NAME_NOT_ALLOWED:int = 553;
        /**
         * Transaction failed  (Or, in the case of a connection-opening response, "No SMTP service here").
         */
        public static const TRANSACTION_FAILED:int = 554;
        /**
         * MAIL FROM/RCPT TO parameters not recognized or not implemented.
         */
        public static const PARAMETERS_NOT_RECOGNIZED:int = 555;
        private static const _kvp:Object = {
            "211" : "System status, or system help reply.",
            "214" : "Help message. (Information on how to use the receiver or the meaning of a particular non-standard command; this reply is useful only to the human user)",
            "220" : "<domain> Service ready.",
            "221" : "&lt;domain&gt; Service closing transmission channel.",
            "250" : "Requested mail action okay, completed.",
            "251" : "User not local; will forward to <forward-path>.",
            "252" : "Cannot VRFY user, but will accept message and attempt delivery.",
            "334" : "",
            "354" : "Start mail input; end with <CRLF>.<CRLF>.",
            "421" : "&lt;domain&gt; Service not available, closing transmission channel. (This may be a reply to any command if the service knows it must shut down)",
            "450" : "Requested mail action not taken: mailbox unavailable (e.g., mailbox busy).",
            "451" : "Requested action aborted: local error in processing.",
            "452" : "Requested action not taken: insufficient system storage.",
            "455" : "Server unable to accommodate parameters.",
            "500" : "Syntax error, command unrecognized. (This may include errors such as command line too long)",
            "501" : "Syntax error in parameters or arguments.",
            "502" : "Command not implemented.",
            "503" : "Bad sequence of commands.",
            "504" : "Command parameter not implemented.",
            "550" : "Requested action not taken: mailbox unavailable. (e.g., mailbox not found, no access, or command rejected for policy reasons)",
            "551" : "User not local; please try <forward-path>.",
            "552" : "Requested mail action aborted: exceeded storage allocation.",
            "553" : "Requested action not taken: mailbox name not allowed. (e.g., mailbox syntax incorrect)",
            "554" : "Transaction failed  (Or, in the case of a connection-opening response, \"No SMTP service here\").",
            "555" : "MAIL FROM/RCPT TO parameters not recognized or not implemented."
        }

        /**
         * Search description by SMTP reply code. return null if parameter is invalid.
         * @param replyCode An valid SMTP reply code.
         * @return The description of reply code.
         */
        public static function searchByCode(replyCode:int):String {
            return _kvp[replyCode] as String;
        }
    }
}