using System;
using System.IO;
using System.Web.UI;

namespace Treni
{
    public partial class RicercaTreni : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CaricaDdlTreni();
        }

        private void CaricaDdlTreni()
        {
            string json = File.ReadAllText("stationList.json");
            //var playerList = JsonConvert.DeserializeObject<List<Player>>(json);
            //var listaTreni = 
        }
    }
}