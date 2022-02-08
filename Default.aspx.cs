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
            new DataColumn("Sequid", typeof(string)),
            new DataColumn("Source", typeof(string)),
            new DataColumn("Type", typeof(string)),
            new DataColumn("Start", typeof(string)),
            new DataColumn("End", typeof(string)),
            new DataColumn("Score", typeof(string)),
            new DataColumn("Strand", typeof(string)),
            new DataColumn("Phase", typeof(string)),
            new DataColumn("Attributes",typeof(string)) });

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

            stato.Text = "Ci sono <strong>" + GridView1.Rows.Count + "</strong> risultati.";
        }

        public void btnSearch_Click(object sender, EventArgs e)
        {
            var contiene = valoriContiene.Value;
            var noncontiene = valoriNonContiene.Value;
            string chiamata = "";
            DataTable dati = Session["data"] as DataTable;
            //(prova as DataTable).DefaultView.RowFilter = string.Format("Attributes = '{0}'", txtRicerca.Text);
            if (contiene != "")
            {
                var listaParole = contiene.Split(';');
                int conteggioParole = listaParole.Count();
                int i = 0;
                foreach (var parola in listaParole)
                {
                    if (i != conteggioParole && i != 0)
                    {
                        chiamata += " and Attributes LIKE '%" + parola + "%'";
                    }
                    else
                    {
                        chiamata += "Attributes LIKE '%" + parola + "%'";
                    }
                    i++;
                }
            }
            if (noncontiene.Trim() != "")
            {
                if (chiamata != "")
                {
                    chiamata += " and ";
                }
                var listaParole = noncontiene.Split(';');
                int conteggioParole = listaParole.Count();
                int i = 0;
                foreach (var parola in listaParole)
                {
                    if (i != conteggioParole && i != 0)
                    {
                        chiamata += " and Attributes not LIKE '%" + parola + "%'";
                    }
                    else
                    {
                        chiamata += "Attributes not LIKE '%" + parola + "%'";
                    }
                    i++;
                }
            }

            if (dati != null)
            {
                (dati as DataTable).DefaultView.RowFilter = chiamata;

                GridView1.DataSource = dati;
                GridView1.DataBind();

                stato.Text = "Ci sono <strong>" + GridView1.Rows.Count + "</strong> risultati.";

                messaggio.Text = "";
            }
            else
            {
                messaggio.Text = "<div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\">" +
                    "<strong>Se non selezioni un file non posso mostrarti nulla :)</strong>" +
                    "<button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" +
                    "</div>";
            }
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
        public string Attributes { get; set; }
    }
}