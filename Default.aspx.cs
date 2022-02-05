using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class _Default : Page
    {
        GridView gdv = null;
        string csvPath = "";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ImportCSV(object sender, EventArgs e)
        {
            //Upload and save the file
            //csvPath = Server.MapPath("~/UploadFiles/") + Path.GetFileName(fileCaricato.PostedFile.FileName);
            //fileCaricato.SaveAs(csvPath);

            string csvPath;
            using (StreamReader inputStreamReader = new StreamReader(fileCaricato.PostedFile.InputStream))
            {
                csvPath = inputStreamReader.ReadToEnd();
            }

            //Create a DataTable.
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[9] {
        new DataColumn("1", typeof(string)),
        new DataColumn("2", typeof(string)),
        new DataColumn("3", typeof(string)),
        new DataColumn("4", typeof(string)),
        new DataColumn("5", typeof(string)),
        new DataColumn("6", typeof(string)),
        new DataColumn("7", typeof(string)),
        new DataColumn("8", typeof(string)),
        new DataColumn("Parametri",typeof(string)) });

            //Read the contents of CSV file.
            //string csvData = File.ReadAllText(csvPath);
            csvPath = csvPath.Replace("##gff-version 3\n", "");

            //Execute a loop over the rows.
            foreach (string row in csvPath.Split('\n'))
            {
                if (!string.IsNullOrEmpty(row))
                {
                    dt.Rows.Add();
                    int i = 0;

                    //Execute a loop over the columns.
                    foreach (string cell in row.Split('\t'))
                    {
                        dt.Rows[dt.Rows.Count - 1][i] = cell;
                        i++;
                    }
                }
            }

            Session["data"] = dt;

            //Bind the DataTable.
            GridView1.DataSource = dt;
            GridView1.DataBind();

            stato.Text = "Ci sono " + GridView1.Rows.Count + " risultati.";
        }

        public void btnSearch_Click(object sender, EventArgs e)
        {
            string chiamata = "";
            DataTable dati = Session["data"] as DataTable;
            //(prova as DataTable).DefaultView.RowFilter = string.Format("Parametri = '{0}'", txtRicerca.Text);
            if (txtContiene.Text.Trim() != "")
            {
                var listaParole = txtContiene.Text.Split(',');
                int conteggioParole = listaParole.Count();
                int i = 0;
                foreach (var parola in listaParole)
                {
                    if (i != conteggioParole && i != 0)
                    {
                        chiamata += " and Parametri LIKE '%" + parola + "%'";
                    }
                    else
                    {
                        chiamata += "Parametri LIKE '%" + parola + "%'";
                    }
                    i++;
                }
            }
            if (txtNonContiene.Text.Trim() != "")
            {
                if (chiamata != "")
                {
                    chiamata += " and ";
                }
                var listaParole = txtNonContiene.Text.Split(',');
                int conteggioParole = listaParole.Count();
                int i = 0;
                foreach (var parola in listaParole)
                {
                    if (i != conteggioParole && i != 0)
                    {
                        chiamata += " and Parametri not LIKE '%" + parola + "%'";
                    }
                    else
                    {
                        chiamata += "Parametri not LIKE '%" + parola + "%'";
                    }
                    i++; 
                }
            }

            (dati as DataTable).DefaultView.RowFilter = chiamata;

            GridView1.DataSource = dati;
            GridView1.DataBind();

            stato.Text = "Ci sono " + GridView1.Rows.Count + " risultati.";
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[6].Visible = false;
            e.Row.Cells[7].Visible = false;
        }
    }

    public class BioQualcosa
    {
        public string Nome { get; set; }
        public string Nome2 { get; set; }
        public string Nome3 { get; set; }
        public string Numero1 { get; set; }
        public string Numero2 { get; set; }
        public string Numero3 { get; set; }
        public string Vuoto1 { get; set; }
        public string Vuoto2 { get; set; }
        public string Parametri { get; set; }
    }
}