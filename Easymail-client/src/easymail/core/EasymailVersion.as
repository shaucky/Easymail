package easymail.core {
    /**
     * The EasymailVersion class provides the version number of the Easymail library.
     * @playerversion AIR 51.0
     */
    public final class EasymailVersion {
        private static const _MAJOR_VERSION:int = 0;
        private static const _MINOR_VERSION:int = 1;
        private static const _REVISION_VERSION:int = 0;

        /**
         * Returns the version of library.
         * @return version of the library.
         */
        public static function get version():String {
            return _MAJOR_VERSION + "." + _MINOR_VERSION + "." + _REVISION_VERSION;
        }
        /**
         * Returns the major version of the library.
         * @return major version of the library.
         */
        public static function get majorVersion():int {
            return _MAJOR_VERSION;
        }
        /**
         * Returns the minor version of the library.
         * @return minor version of the library.
         */
        public static function get minorVersion():int {
            return _MINOR_VERSION;
        }
        /**
         * Returns the revision version of the library.
         * @return revision version of the library.
         */
        public static function get revisionVersion():int {
            return _REVISION_VERSION;
        }
    }
}