<%@ Page
    Title="Ricerca Treni"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="RicercaTreni.aspx.cs"
    Inherits="WebApplication1.SiteMaster" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" CssClass="container-lg">
    <%--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">--%>
    <%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">--%>
    <script
        src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .container {
            margin-top: 20px;
        }

        td {
            min-width: 70px;
        }

        p {
            font-style: italic;
            font-weight: lighter;
        }

        .animated {
            -webkit-transition: height 0.2s;
            -moz-transition: height 0.2s;
            transition: height 0.2s;
        }

        .textbox {
            width: 300px;
        }

        .stato {
            text-align: center;
            padding: 15px;
        }

        /*.ele-contiene-list button {
            float: right;
            margin: 2px;
        }

        .ele-noncontiene-list button {
            float: right;
            margin: 2px;
        }*/

        .ele-contiene-list .list-group-item, .ele-noncontiene-list .list-group-item {
            clear: both;
            padding: 0;
        }

            .ele-contiene-list .list-group-item span, .ele-noncontiene-list .list-group-item span {
                display: inline-block;
                padding: 8px;
            }

        .ele-contiene-list button, .ele-noncontiene-list button {
            float: right;
            margin: 2px;
        }

        .ele-contiene .input-group input[type="text"], .ele-noncontiene .input-group input[type="text"] {
            width: 1%;
            padding: 0.375rem 0.75rem;
            margin: 0;
            border-right: 0;
        }

        .ele-contiene .input-group button, .ele-noncontiene .input-group button {
            margin: 0;
            padding: 0.375rem 0.75rem;
        }

        .StickyHeader th {
            position: sticky;
            top: 60px;
            background-color: #14989d;
        }

        .Footer {
            background-color: #14989d;
        }

        #btnCarica {
            margin-top: 10px;
        }
        .table a{
            color: white;
        }
    </style>

    <div class="container">
        <div>
            <h2>Ricerca treni</h2>
            <div style="font-size: small;">Tool per lo studio di file in formato .gff3<br />È possibile effettuare le seguenti operazioni: </div>
            <ul style="font-size: small;">
                <li>
                    caricare e visualizzare file in formato .gff3
                </li>
                <li>
                    Filtrare la lista impostando parole da ricercare/escludere
                </li>
                <li>
                    Mostrare/Nascondere le colonne della tabella
                </li>
                <li>
                    Ordinare la tabella in ordine crescente/decrescente
                </li>
                <li>
                    Esportare la tabella in formato excel
                </li>
                <li>
                    Ordinare la tabella in ordine crescente/decrescente (cliccare sul nome della colonna)
                </li>
            </ul>
            <asp:Panel ID="panRicercaTreni" runat="server">
                <div class="row">
                    <div class="col-md-2">
                        <asp:Label ID="lblTreni" runat="server"><strong>Seleziona le stazioni:</strong></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:DropDownList ID="ddlStazionePartenza" runat="server"></asp:DropDownList>
                    </div>
                    <div class="col-md-6">
                        <asp:DropDownList ID="ddlStazioneArrivo" runat="server"></asp:DropDownList>
                    </div>
                </div>
            </asp:Panel>

        </div>
    </div>
</asp:Content>
