<%@ Page
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="RicercaTreno.aspx.cs"
    Inherits="WebApplication1.Treni.RicercaTreno" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" CssClass="container-lg">
    <style>
        #messaggio{
            position: fixed;
            top: 0;
            right: 0;
            z-index: 999999;
        }
    </style>
    <script
        src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <asp:Label ID="messaggio" ClientIDMode="Static" runat="server"></asp:Label>
    <div class="container">
        <div>
            <h2>Ricerca treni</h2>
            <div style="font-size: small;">Tool per la ricerca di treni<br />
                È possibile effettuare le seguenti operazioni: </div>
            <ul style="font-size: small;">
                <li>ricercare un treno impostando la stazione di partenza e di destinazione
                </li>
                <li>ricercare un treno impostando la data
                </li>
                <li>ricercare un treno impostando una data inizio e una data fine
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
                <div class="row">
                    <div class="col-md-2">
                        <asp:Label ID="Label1" runat="server"><strong>Seleziona un intervallo di date:</strong></asp:Label>
                    </div>
                    <div class="col-md-4">
                        <asp:TextBox TextMode="Date" ID="txtDataInizio" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox TextMode="Date" ID="txtDataFine" runat="server"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnRicercaTreni" runat="server" OnClick="btnRicercaTreni_Click" Text="Ricerca" />
            </asp:Panel>

            <!-- Tabella -->
        <asp:GridView 
            ID="gdvTreni" 
            runat="server" 
            AlternatingRowStyle-CssClass="alt" 
            AutoGenerateColumns="false"
            Width="100%" border="1" CellPadding="3" CssClass="table table-striped table-bordered table-hover"
            Style="border: 1px solid #E5E5E5; word-break: break-all; word-wrap: break-word">
            <HeaderStyle CssClass="StickyHeader" />
            <PagerStyle CssClass="Footer" />
            <Columns>
                <asp:BoundField DataField="origin" HeaderText="Stazione partenza" ItemStyle-CssClass="short" HeaderStyle-CssClass="short"  SortExpression="sequid"/>
                <asp:BoundField DataField="destination" HeaderText="Stazione arrivo" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="source" />
                <asp:BoundField DataField="DataPartenza" HeaderText="Data partenza" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="type" />
                <asp:BoundField DataField="DataArrivo" HeaderText="Data arrivo" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="start"/>
                <asp:BoundField DataField="minprice" HeaderText="Prezzo" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="end" />
                <asp:BoundField DataField="duration" HeaderText="Durata" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="end" />
            </Columns>
        </asp:GridView>
        </div>
    </div>
</asp:Content>
