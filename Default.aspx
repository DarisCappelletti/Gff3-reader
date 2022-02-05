<%@ Page 
    Title="Gff3 reader" 
    Language="C#" 
    MasterPageFile="~/Site.Master" 
    AutoEventWireup="true" 
    CodeBehind="Default.aspx.cs" 
    Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
    <style>
        td {
            min-width: 70px;
        }
        p {
            font-style: italic;
        }
    </style>
    <div class="row">
        <div class="col-md-4">
            <h2>Programma molto figo / Gff3 reader</h2>
            <p>
            Proviamo a cercare qualche micro-tizio insieme!</p>
            <div class="row">
                <div class="col-md-4">
                    <asp:Label ID="lblFile" runat="server">Scegli il file:</asp:Label>
                </div>
                <div class="col-md-8">
                    <asp:FileUpload ID="fileCaricato" runat="server" />
                    <p>Selezionare un file in formato .gff3 e cliccare sul pulsante carica</p>
                    <asp:Button ID="btnCarica" runat="server" Text="Carica file" OnClick="ImportCSV" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <asp:Label ID="lblFiltro" runat="server">Contiene:</asp:Label>
                </div>
                <div class="col-md-8">
                    <asp:TextBox ID="txtContiene" runat="server"></asp:TextBox>
                    <p>*è possibile inserire più parole da ricercare separandole con la virgola esempio: prova,prova1,prova2</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <asp:Label ID="lblNonContiene" runat="server">Non contiene:</asp:Label>
                </div>
                <div class="col-md-8">
                    <asp:TextBox ID="txtNonContiene" runat="server"></asp:TextBox>
                    <p>*è possibile inserire più parole da ricercare separandole con la virgola esempio: prova,prova1,prova2</p>
                </div>
            </div>
            <asp:Button ID="btnRicerca" runat="server" Text="Cerca" OnClick="btnSearch_Click" />
        </div>
        <asp:Label ID="stato" runat="server"></asp:Label>
        <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound"
            AlternatingRowStyle-CssClass="alt"
            Width="100%" border="1" CellPadding="3"
            style="border: 1px solid #E5E5E5; word-break:break-all; word-wrap:break-word">
        </asp:GridView>
    </div>
</asp:Content>
