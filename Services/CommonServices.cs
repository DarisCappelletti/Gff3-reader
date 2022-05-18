using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using WebApplication1.Enums;

namespace WebApplication1.Services
{
    public class CommonServices
    {
        public static void ShowAlert(Label label, Alerts obj, string message)
        {
            string alertDiv = null;
            switch (obj)
            {
                case Alerts.Success:
                    label.Text =
                        "<div class=\"alert alert-success alert-dismissible fade show\" role=\"alert\">" +
                        "<strong>Successo!</strong> " + message +
                        "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button></div>";
                    break;
                case Alerts.Danger:
                    label.Text = "<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\">" +
                        "<strong>Errore!</strong> " + message +
                        "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button></div>";
                    break;
                case Alerts.Info:
                    label.Text =
                        "<div class=\"alert alert-info alert-dismissible fade show\" role=\"alert\">" +
                        "<strong>Info!</strong> " + message +
                        "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button></div>";
                    break;
                case Alerts.Warning:
                    label.Text = "<div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\">" +
                        "<strong>Attenzione!</strong> " + message +
                        "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button></div>";


                    break;
            }
        }
    }
}