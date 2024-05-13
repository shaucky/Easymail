package easymail.smtp {
    /**
     * The SMTPSyntax class provides RegExp constants that match the format of SMTP parameters.
     * <p>According to RFC 5321 and RFC 4954 specification, command argument syntax should follow certain rules. Here are some RegExp constants provided for match these rules.</p>
     * @playerversion AIR 51.0
     */
    public class SMTPSyntax {
        //The followings are defined by RFC 5321:
        public static const REVERSE_PATH:RegExp = /^((([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?)@([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?\.)*[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]))$/;
        public static const FORWARD_PATH:RegExp = /^(([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?)@([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?\.)*[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9])$/;
        public static const PATH:RegExp = /^((@([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?(\.([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?))*,)*:)?(([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?)@([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?\.)*[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]))$/;
        public static const A_D_L:RegExp = /^@([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?(\.([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?))*)(,(@[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?(\.([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?))*))*)$/;
        public static const AT_DOMAIN:RegExp = /^@([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?(\.([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?))*$/;
        public static const MAIL_PARAMETERS:RegExp = /^[\w-]+(=[\x21\x23-\x3B\x3D\x3F-\x7E]+)?( [\w-]+(=[\x21\x23-\x3B\x3D\x3F-\x7E]+)?)*$/;
        public static const RCPT_PARAMETERS:RegExp = /^[\w-]+(=[\x21\x23-\x3B\x3D\x3F-\x7E]+)?( [\w-]+(=[\x21\x23-\x3B\x3D\x3F-\x7E]+)?)*$/;
        public static const ESMTP_PARAM:RegExp = /^[\w-]+(=[\x21\x23-\x3B\x3D\x3F-\x7E]+)?$/;
        public static const ESMTP_KEYWORD:RegExp = /^[\w-]+$/;
        public static const ESMTP_VALUE:RegExp = /^[\x21\x23-\x3B\x3D\x3F-\x7E]+$/;
        public static const KEYWORD:RegExp = /^[A-Za-z0-9-]*[A-Za-z0-9]$/;
        public static const DOMAIN:RegExp = /^([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?\.)*[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?$/;
        public static const SUB_DOMAIN:RegExp = /^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?$/;
        public static const LET_DIG:RegExp = /^[A-Za-z0-9]$/;
        public static const LDH_STR:RegExp = /^[A-Za-z0-9-]*[A-Za-z0-9]/;
        public static const ADDRESS_LITERAL:RegExp = /^(^\[([0-9]{1,3}\.){3}[0-9]{1,3}\])|(^\[([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}\])|(^\[([0-9A-Fa-f]{1,4}(:[0-9A-Fa-f]{1,4}){0,5})?::([0-9A-Fa-f]{1,4}(:[0-9A-Fa-f]{1,4}){0,5})?\])$/
        public static const MAILBOX:RegExp = /^(([\w!#$%&'*+-\/=?^_`{|}~]+(\.[\w!#$%&'*+-\/=?^_`{|}~]+)*)|("[\x20-\x21\x23-\x5B\x5D-\x7E\x5C\x20-\x7E]*"))@((([A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?\.)*[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]?)|\[([0-9]{1,3}\.){3}[0-9]{1,3}\])$/;
        public static const LOCAL_PART:RegExp = /^(([\w!#$%&'*+-\/=?^_`{|}~]+(\.[\w!#$%&'*+-\/=?^_`{|}~]+)*)|("[\x20-\x21\x23-\x5B\x5D-\x7E\x5C\x20-\x7E]*"))$/;
        public static const DOT_STRING:RegExp = /^[\w!#$%&'*+-\/=?^_`{|}~]+(\.[\w!#$%&'*+-\/=?^_`{|}~]+)*$/;
        public static const ATOM:RegExp = /^[\w!#$%&'*+-\/=?^_`{|}~]+$/;
        public static const QUOTED_STRING:RegExp = /^"[\x20-\x21\x23-\x5B\x5D-\x7E\x5C\x20-\x7E]*"$/;
        public static const QCONTENTSMTP:RegExp = /^[\x20-\x21\x23-\x5B\x5D-\x7E\x5C\x20-\x7E]*$/;
        public static const QUOTED_PAIR_SMTP:RegExp = /^\\[\x20-\x7E]$/;
        public static const QTEXTSMTP:RegExp = /^[\x20-\x21\x23-\x5B\x5D-\x7E]*$/;
        public static const STRING:RegExp = /^([\w!#$%&'*+-\/=?^_`{|}~]+)|("[\x20-\x21\x23-\x5B\x5D-\x7E\x5C\x20-\x7E]*")$/;
        //The followings are defined by RFC 4954:
        public static const HEXCHAR:RegExp = /^\+[0-9A-Fa-f]{2}$/;
        public static const XCHAR:RegExp = /^[\x21-\x2A\x2C-\x3C\x3E-\x7E]$/;
        public static const XTEXT:RegExp = /^([\x21-\x2A\x2C-\x3C\x3E-\x7E]|\+[0-9A-Fa-f]{2})*$/;
        public static const BASE64_CHAR:RegExp = /^[A-Za-z0-9+\/]$/;
        public static const BASE64_TERMINAL:RegExp = /^([A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)$/;
        public static const BASE64:RegExp = /^([A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})*$/;
        public static const INITIAL_RESPONSE:RegExp = /^([A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})*|=$/;
        public static const CONTINUE_REQ:RegExp = /^334 \s([A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})*\r\n$/;
        public static const AUTH_COMMAND:RegExp = /^AUTH \s([a-zA-Z0-9-_]+)( \s([A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})*|=)?(\r\n([A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})*\r\n)*(\r\n\*)?\r\n$/;
        public static const AUTH_PARAM:RegExp = /^AUTH=([\x21-\x2A\x2C-\x3C\x3E-\x7E]|\+[0-9A-Fa-f]{2})*$/;
        public static const CANCEL_RESPONSE:RegExp = /^\*$/;
        //Others:
        public static const SASL_MECH:RegExp = /^[A-Z0-9-_]{1,20}$/; //RFC 4422

        public function SMTPSyntax() {
            //
        }
    }
}