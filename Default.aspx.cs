using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable dati = Session["data"] as DataTable;
                if (dati != null)
                {
                    if (Session["contiene"] != null)
                    {
                        valoriContiene.Value = Session["contiene"].ToString();
                    }
                    if (Session["noncontiene"] != null)
                    {
                        valoriNonContiene.Value = Session["noncontiene"].ToString();
                    }
                    creaBioColonne();
                    aggiornaTabella(dati);
                }
                visualizzaFileCaricato();
            }
        }

        public void creaBioColonne()
        {
            var bioColonne = new BioQualcosa();
            bioColonne.Sequid = true;
            bioColonne.Source = true;
            bioColonne.Type = true;
            bioColonne.Start = true;
            bioColonne.End = true;
            bioColonne.Score = true;
            bioColonne.Strand = true;
            bioColonne.Phase = true;
            bioColonne.Attributes = true;
            Session["bioColonne"] = bioColonne;
        }

        protected void ImportCSV(object sender, EventArgs e)
        {
            //Upload and save the file
            //csvPath = Server.MapPath("~/UploadFiles/") + Path.GetFileName(fileCaricato.PostedFile.FileName);
            //fileCaricato.SaveAs(csvPath);

            creaBioColonne();
            
            string csvPath;
            using (StreamReader inputStreamReader = new StreamReader(fileCaricato.PostedFile.InputStream))
            {
                csvPath = inputStreamReader.ReadToEnd();
            }

            Session["nomeFile"] = fileCaricato.PostedFile.FileName;

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

            //Execute a loop over the rows.
            foreach (string row in csvPath.Split('\n'))
            {
                // Se la riga non è vuota e non è un commento la aggiungo
                if (!string.IsNullOrEmpty(row) && !row.StartsWith("#"))
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
            aggiornaTabella(dt);
            visualizzaFileCaricato();
        }

        public void btnSearch_Click(object sender, EventArgs e)
        {
            var contiene = valoriContiene.Value;
            var noncontiene = valoriNonContiene.Value;
            string chiamata = "";
            
            //(prova as DataTable).DefaultView.RowFilter = string.Format("Attributes = '{0}'", txtRicerca.Text);
            if (contiene != "")
            {
                Session["contiene"] = contiene;
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
                Session["noncontiene"] = noncontiene;
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

            DataTable dati = Session["data"] as DataTable;
            if (dati != null)
            {
                (dati as DataTable).DefaultView.RowFilter = chiamata;

                aggiornaTabella(dati);
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
            BioQualcosa bioColonne = Session["bioColonne"] as BioQualcosa;
            if (bioColonne != null)
            {
                if (bioColonne.Sequid == true) { e.Row.Cells[0].Visible = true; } else { e.Row.Cells[0].Visible = false; }
                if (bioColonne.Source == true) { e.Row.Cells[1].Visible = true; } else { e.Row.Cells[1].Visible = false; }
                if (bioColonne.Type == true) { e.Row.Cells[2].Visible = true; } else { e.Row.Cells[2].Visible = false; }
                if (bioColonne.Start == true) { e.Row.Cells[3].Visible = true; } else { e.Row.Cells[3].Visible = false; }
                if (bioColonne.End == true) { e.Row.Cells[4].Visible = true; } else { e.Row.Cells[4].Visible = false; }
                if (bioColonne.Score == true) { e.Row.Cells[5].Visible = true; } else { e.Row.Cells[5].Visible = false; }
                if (bioColonne.Strand == true) { e.Row.Cells[6].Visible = true; } else { e.Row.Cells[6].Visible = false; }
                if (bioColonne.Phase == true) { e.Row.Cells[7].Visible = true; } else { e.Row.Cells[7].Visible = false; }
                if (bioColonne.Attributes == true) { e.Row.Cells[8].Visible = true; } else { e.Row.Cells[8].Visible = false; }
            }
        }
        public void aggiornaTabella(DataTable dati)
        {
            if (dati != null)
            {
                GridView1.DataSource = dati;
                GridView1.DataBind();

                stato.Text = "Ci sono <strong>" + GridView1.Rows.Count + "</strong> risultati.";

                messaggio.Text = "";
                pulsantiColonne.Visible = true;
            }
            else
            {
                pulsantiColonne.Visible = false;
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        public void visualizzaFileCaricato()
        {
            if (Session["nomeFile"] != null)
            {
                litFileCaricato.Visible = true;
                litFileCaricato.Text = "<strong>File attivo:</strong> " + Session["nomeFile"].ToString();
            }
            else
            {
                litFileCaricato.Text = "";
                litFileCaricato.Visible = false;
            }
        }

        protected void btnEsportaExcel_Click(object sender, EventArgs e)
        {
            ExportGridToExcel();
        }

        private void ExportGridToExcel()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.ClearContent();
            Response.ClearHeaders();
            Response.Charset = "";
            string FileName = "Vithal" + DateTime.Now + ".xls";
            StringWriter strwritter = new StringWriter();
            HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            GridView1.GridLines = GridLines.Both;
            GridView1.HeaderStyle.Font.Bold = true;
            GridView1.RenderControl(htmltextwrtter);
            Response.Write(strwritter.ToString());
            Response.End();
        }

        public void mostraNascondiColonne(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            DataTable dati = Session["data"] as DataTable;
            BioQualcosa bioColonne = Session["bioColonne"] as BioQualcosa;
            if (button.CommandName == "1")
            {
                bioColonne.Sequid = bioColonne.Sequid == true ? bioColonne.Sequid = false : bioColonne.Sequid = true;
                aggiornaBottoni(button, bioColonne.Sequid);
            }
            else if (button.CommandName == "2")
            {
                bioColonne.Source = bioColonne.Source == true ? bioColonne.Source = false : bioColonne.Source = true;
                aggiornaBottoni(button, bioColonne.Source);
            }
            else if (button.CommandName == "3")
            {
                bioColonne.Type = bioColonne.Type == true ? bioColonne.Type = false : bioColonne.Type = true;
                aggiornaBottoni(button, bioColonne.Type);
            }
            else if (button.CommandName == "4")
            {
                bioColonne.Start = bioColonne.Start == true ? bioColonne.Start = false : bioColonne.Start = true;
                aggiornaBottoni(button, bioColonne.Start);
            }
            else if (button.CommandName == "5")
            {
                bioColonne.End = bioColonne.End == true ? bioColonne.End = false : bioColonne.End = true;
                aggiornaBottoni(button, bioColonne.End);
            }
            else if (button.CommandName == "6")
            {
                bioColonne.Score = bioColonne.Score == true ? bioColonne.Score = false : bioColonne.Score = true;
                aggiornaBottoni(button, bioColonne.Score);
            }
            else if (button.CommandName == "7")
            {
                bioColonne.Strand = bioColonne.Strand == true ? bioColonne.Strand = false : bioColonne.Strand = true;
                aggiornaBottoni(button, bioColonne.Strand);
            }
            else if (button.CommandName == "8")
            {
                bioColonne.Phase = bioColonne.Phase == true ? bioColonne.Phase = false : bioColonne.Phase = true;
                aggiornaBottoni(button, bioColonne.Phase);
            }
            else if (button.CommandName == "9")
            {
                bioColonne.Attributes = bioColonne.Attributes == true ? bioColonne.Attributes = false : bioColonne.Attributes = true;
                aggiornaBottoni(button, bioColonne.Attributes);
            }

            Session["bioColonne"] = bioColonne;

            //Bind the DataTable.
            aggiornaTabella(dati);
        }

        public void aggiornaBottoni(Button button, bool attivo)
        {
            button.CssClass = attivo ? "btn btn-danger" : "btn btn-success";
        }
    }

    public class BioQualcosa
    {
        public bool Sequid { get; set; }
        public bool Source { get; set; }
        public bool Type { get; set; }
        public bool Start { get; set; }
        public bool End { get; set; }
        public bool Score { get; set; }
        public bool Strand { get; set; }
        public bool Phase { get; set; }
        public bool Attributes { get; set; }
    }

    public class BioTizio
    {
        public string Sequid { get; set; }
        public string Source { get; set; }
        public string Type { get; set; }
        public string Start { get; set; }
        public string End { get; set; }
        public string Score { get; set; }
        public string Strand { get; set; }
        public string Phase { get; set; }
        public string Attributes { get; set; }
    }
}