using System.Net.Sockets;

namespace Easymail
{
    public class Connection
    {
        protected string _host;
        protected string _localHostName;
        protected int _port;
        protected Socket _socket;
        public Connection()
        {
            //
        }
    }
}
