using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DatMonAn_Cloud.Models
{
    public class AccountLogin
    {
        public string email { get; set; }
        public string matKhau { get; set; }
        public AccountLogin() { }

        public AccountLogin(string name, string pass)
        {
            this.email = name;
            this.matKhau = pass;
        }
    }
}