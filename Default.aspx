<%@ Page
    Title="Gff3 reader"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    MaintainScrollPositionOnPostback="true"
    CodeBehind="Default.aspx.cs"
    EnableEventValidation="false"
    Inherits="WebApplication1._Default" %>

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

        .btn-operazioni {
            max-width: 120px;
            display: flex;
        }

        .card {
            -webkit-box-shadow: 0px 0px 6px 0px #000000; 
            box-shadow: 0px 0px 6px 0px #000000;
        }

        #btn-back-to-top {
          position: fixed;
          bottom: 20px;
          right: 20px;
          display: none;
        }
    </style>

    <div class="container">
        <asp:Literal ID="messaggio" runat="server"></asp:Literal>
        <div>
            <h1>Gff3 reader</h1>
            <h2>Tool per lo studio di file in formato .gff3</h2>
            <div class="accordion mb-3" id="accordionDettagli">
                <div class="accordion-item">
                <h2 class="accordion-header" id="headingThree">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        Funzionalità disponibili
                    </button>
                </h2>
                <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionDettagli">
                    <div class="accordion-body">
                        <div style="font-size: small;">È possibile effettuare le seguenti operazioni: </div>
                        <ul style="font-size: small;">
                            <li>
                                caricare e visualizzare uno o più file in formato .gff3
                            </li>
                            <li>
                                Filtrare la lista impostando parole da ricercare/escludere
                            </li>
                            <li>
                                Mostrare/Nascondere le colonne della tabella
                            </li>
                            <li>
                                Esportare la tabella in formato excel
                            </li>
                            <li>
                                Ordinare la tabella in ordine crescente/decrescente (cliccare sul nome della colonna)
                            </li>
                            <li>
                                Impostare il numero di risultati da visualizzare
                            </li>
                        </ul>
                    </div>
                </div>
                </div>
            </div>
            
            <asp:Panel ID="panRicerca" runat="server" DefaultButton="btnRicerca">
                <div class="card p-3 mb-3">
                    <h5 class="card-title">File</h5>
                    <p class="card-text">Seleziona uno o più file in formato .gff3 e clicca sul pulsante carica. I risultati verranno mostrati in un unica tabella.</p>
                    <div class="card-body row">
                        <div class="col-md-5">
                            <asp:FileUpload ID="fileCaricato" runat="server" CssClass="form-control" AllowMultiple="true" />
                            <asp:Button
                                ID="btnCarica"
                                runat="server"
                                ClientIDMode="Static"
                                Text="Carica file"
                                CssClass="btn btn-secondary"
                                OnClick="ImportCSV"
                                OnClientClick="showLoading();" />
                        </div>
                        <div class="col-md-7">
                            <asp:Literal ID="litFileCaricato" runat="server" Visible="false"></asp:Literal>
                        </div>
                    </div>
                </div>

                <div class="card p-3">
                    <h5 class="card-title">Filtri</h5>
                    <p class="card-text">Filtrare i risultati per parole che devono/non devono essere presenti con la possibilità di selezionare su quale colonna/colonne
                        effettuare la ricerca.
                    </p>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-2">
                                <asp:Label ID="lblFiltro" runat="server"><strong>Contiene:</strong></asp:Label>
                            </div>
                            <div class="col-md-5">
                                <div class="ele-contiene" style="">
                                    <div class="ele-contiene-list list-group"></div>
                                    <div class="input-group mb-3">
                                        <input type="text"
                                            class="ele-contiene-edit form-control"
                                            placeholder="Parola da ricercare"
                                            aria-label="Parola da ricercare"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="ele-contiene-add btn btn-success"
                                                role="button"
                                                type="button">
                                                <i class="fa fa-plus" aria-hidden="true"></i>
                                                Aggiungi
                                            </button>
                                        </div>
                                    </div>
                                    <asp:HiddenField ID="valoriContiene" runat="server" ClientIDMode="Static" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">
                                <asp:Label ID="lblNonContiene" runat="server"><strong>Non contiene:</strong></asp:Label>
                            </div>
                            <div class="col-md-5">
                                <div class="ele-noncontiene">
                                    <div class="ele-noncontiene-list list-group"></div>
                                    <div class="input-group mb-3">
                                        <input type="text"
                                            class="ele-noncontiene-edit form-control"
                                            placeholder="Parola da rimuovere"
                                            aria-label="Parola da rimuovere"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="ele-noncontiene-add btn btn-success"
                                                role="button"
                                                type="button">
                                                <i class="fa fa-plus" aria-hidden="true"></i>
                                                Aggiungi
                                            </button>
                                        </div>
                                    </div>
                                    <asp:HiddenField ID="valoriNonContiene" runat="server" ClientIDMode="Static" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-2">
                                <strong>Ricerca in:</strong>
                            </div>
                            <div class="col-md-10">
                                <asp:CheckBoxList ID="cklColonne" runat="server" AutoPostBack="false" RepeatLayout="Table"  RepeatDirection="Horizontal">
                                    <asp:ListItem Value="File" Selected="True">File</asp:ListItem>
                                    <asp:ListItem Value="Sequid" Selected="True">Sequid</asp:ListItem>
                                    <asp:ListItem Value="Source" Selected="True">Source</asp:ListItem>
                                    <asp:ListItem Value="Type" Selected="True">Type</asp:ListItem>
                                    <asp:ListItem Value="Start" Selected="True">Start</asp:ListItem>
                                    <asp:ListItem Value="End" Selected="True">End</asp:ListItem>
                                    <asp:ListItem Value="Score" Selected="True">Score</asp:ListItem>
                                    <asp:ListItem Value="Strand" Selected="True">Strand</asp:ListItem>
                                    <asp:ListItem Value="Phase" Selected="True">Phase</asp:ListItem>
                                    <asp:ListItem Value="Attributes" Selected="True">Attributes</asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>
                        <p>
                            *Inserire la parola da ricercare/escludere e cliccare sul pulsante "Aggiungi". 
                            (esempio: scrivo la parola "pippo" e clicco su aggiungi, poi scrivo "paperino" e clicco su aggiungi.
                            Per eliminare una parola cliccare sul pulsante rosso che apparirà.
                            Infine cliccare su "Applica i filtri" per filtrare la lista.

                        </p>

                        <div style="display: inline-flex;">
                            <asp:Button
                            ID="btnRicerca"
                            runat="server"
                            CssClass="btn btn-primary btn-operazioni"
                            Text="Applica i filtri"
                            OnClick="btnSearch_Click"
                            OnClientClick="showLoading();" />
                        <asp:Button
                            ID="btnEliminaFiltri"
                            runat="server"
                            CssClass="btn btn-danger btn-operazioni"
                            Text="Elimina filtri"
                            OnClick="btnEliminaFiltri_Click" />
                        <asp:Button
                            ID="btnEsportaExcel"
                            runat="server"
                            CssClass="btn btn-secondary btn-operazioni"
                            Text="Esporta excel"
                            OnClick="btnEsportaExcel_Click" />
                        </div>
                    </div>
                </div>
            </asp:Panel>

        </div>

        <!-- stato -->
        <div class="stato">
            <asp:Label ID="stato" runat="server"></asp:Label>
        </div>

        <!-- pulsanti tabella -->
        <div id="pulsantiColonne" runat="server" visible="false">
            <div class="row">
                <div class="col-md-2">
                    <asp:Label ID="lblPulsantiColonne" runat="server"><strong>Mostra/Nascondi colonne:</strong></asp:Label>
                </div>
                <div class="col-md-8">
                    <asp:Button ID="colonna0" runat="server" CommandName="1" OnClick="mostraNascondiColonne" Text="File" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                    <asp:Button ID="colonna1" runat="server" CommandName="2" OnClick="mostraNascondiColonne" Text="Sequid" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                    <asp:Button ID="colonna2" runat="server" CommandName="3" OnClick="mostraNascondiColonne" Text="Source" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                    <asp:Button ID="colonna3" runat="server" CommandName="4" OnClick="mostraNascondiColonne" Text="Type" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                    <asp:Button ID="colonna4" runat="server" CommandName="5" OnClick="mostraNascondiColonne" Text="Start" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                    <asp:Button ID="colonna5" runat="server" CommandName="6" OnClick="mostraNascondiColonne" Text="End" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                    <asp:Button ID="colonna6" runat="server" CommandName="7" OnClick="mostraNascondiColonne" Text="Score" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                    <asp:Button ID="colonna7" runat="server" CommandName="8" OnClick="mostraNascondiColonne" Text="Strand" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                    <asp:Button ID="colonna8" runat="server" CommandName="9" OnClick="mostraNascondiColonne" Text="Phase" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                    <asp:Button ID="colonna9" runat="server" CommandName="10" OnClick="mostraNascondiColonne" Text="Attributes" CssClass="btn btn-danger" OnClientClick="showLoading();"/>
                </div>
                <div class="col-md-2">
                    Risultati:
                    <asp:DropDownList 
                        ID="ddlNumeroPagine" 
                        runat="server" 
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlNumeroRisultati_SelectedIndexChanged">
                    <asp:ListItem Value="100">100</asp:ListItem>
                    <asp:ListItem Value="500">500</asp:ListItem>
                    <asp:ListItem Value="1000">1000</asp:ListItem>
                    <asp:ListItem Value="2000" Selected="True">2000</asp:ListItem>
                    <asp:ListItem Value="4000">4000</asp:ListItem>
                    <asp:ListItem Value="all">Tutti</asp:ListItem>
                </asp:DropDownList>
                </div>
            </div>
        </div>

        <!-- Tabella -->
        <asp:GridView 
            ID="GridView1" 
            runat="server" 
            OnRowDataBound="GridView1_RowDataBound" 
            OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="true" PageSize="2000"
            OnSorting="GridView1_Sorting" AllowSorting="true" CurrentSortDir="ASC" CurrentSortField="sequid"
            AlternatingRowStyle-CssClass="alt" 
            AutoGenerateColumns="false"
            Width="100%" border="1" CellPadding="3" CssClass="table table-striped table-bordered table-hover"
            Style="border: 1px solid #E5E5E5; word-break: break-all; word-wrap: break-word">
            <HeaderStyle CssClass="StickyHeader" />
            <PagerStyle CssClass="Footer" />
            <Columns>
                <asp:BoundField DataField="File" HeaderText="File" SortExpression="file"/>
                <asp:BoundField DataField="Sequid" HeaderText="Sequid" ItemStyle-CssClass="short" HeaderStyle-CssClass="short"  SortExpression="sequid"/>
                <asp:BoundField DataField="Source" HeaderText="Source" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="source" />
                <asp:BoundField DataField="Type" HeaderText="Type" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="type" />
                <asp:BoundField DataField="Start" HeaderText="Start" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="start"/>
                <asp:BoundField DataField="End" HeaderText="End" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="end" />
                <asp:BoundField DataField="Score" HeaderText="Score" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="score" />
                <asp:BoundField DataField="Strand" HeaderText="Strand" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="strand" />
                <asp:BoundField DataField="Phase" HeaderText="Phase" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="phase" />
                <asp:BoundField DataField="Attributes" HeaderText="Attributes" ItemStyle-CssClass="short" HeaderStyle-CssClass="short" SortExpression="attributes" />
            </Columns>
        </asp:GridView>

        <button
            type="button"
            class="btn btn-danger btn-floating btn-lg"
            id="btn-back-to-top"
            >
            <i class="fas fa-arrow-up"></i>
        </button>
    </div>

    <!-- Tipo campo Elenco -->
    <script>
        function removeItemContiene(el) {
            let hid = $('.ele-contiene input[type=hidden]')
            let valoreStringa = el.parent('.list-group-item').attr('valoreStringa')
            if (hid.length > 0 && hid.val() != null) {
                // ottengo un array degli elementi della lista
                listaDati = hid.val().split(';')
                console.log(listaDati)
                // rimuovo elemento da array
                for (var i = listaDati.length - 1; i >= 0; i--) {
                    if (listaDati[i] === valoreStringa) {
                        listaDati.splice(i, 1)
                        break
                    }
                }
                console.log(listaDati)
                // aggiorno la input hidden
                hid.val(listaDati.join(';'))

                // eliminazione elemento dalla lista
                $('.ele-contiene-list .list-group-item').each(function () {
                    let value = $(this).children('span').text()
                    if (value == valoreStringa) {
                        // elimino la riga
                        $(this).remove()
                    }
                })
            }
        }

        function removeItemContieneEdit(el) {
            let valoreStringa = el.parent('.list-group-item').attr('valoreStringa')
            let hid = $('#valoriContiene')
            if (hid.length > 0 && hid.val() != null) {
                // ottengo un array degli elementi della lista
                listaDati = hid.val().split(';')
                // rimuovo elemento da array
                for (var i = listaDati.length - 1; i >= 0; i--) {
                    if (listaDati[i] === valoreStringa) {
                        listaDati.splice(i, 1)
                        break
                    }
                }

                // aggiorno la input hidden
                hid.val(listaDati.join(';'))

                // eliminazione elemento dalla lista
                $('.ele-contiene-list .list-group-item').each(function () {
                    let value = $(this).children('span').text()
                    if (value == valoreStringa) {
                        // elimino la riga
                        $(this).remove()
                    }
                })
            }
        }

        function loadListContieneInEdit() {
            // carico hidden con gli elementi dell'elenco
            let loadedHid = $('#valoriContiene')

            if (loadedHid && loadedHid.val()) {
                // ottengo un array degli elementi della lista
                let listaDati = loadedHid.val().split(';')

                // visualizzo la lista
                listaDati.forEach(element => {
                    $('.ele-contiene-list').append(
                        '<div class="list-group-item" valoreStringa="' + escapeHtml(element) + '"><span>' + element + '</span>' +
                        '<button class="ele-contiene-remove btn btn-danger btn-sm" onclick="removeItemContieneEdit(' +
                        '$(this)' + ')" role="button" type="button">' +
                        '<i class="fa fa-trash" aria-hidden="true"></i>' +
                        '</button>' +
                        '</div>'
                    )
                })
            }
        }

        $(document).ready(function () {
            // carico la lista in modifica
            loadListContieneInEdit()

            $('.ele-contiene-add').click(function () {
                let edit = $(this).parent().siblings('.ele-contiene-edit')
                if (edit.length > 0 && edit.val() != '') {
                    // valore nuovo elemento
                    let oldElement = $.trim(edit.val())
                    let newElement = escapeHtml(oldElement)
                    // pulisco la textbox di input
                    edit.val('')

                    // inserisco elemento nel campo hidden
                    let hid = $(this).parent().parent().siblings('input[type=hidden]')
                    let hidText = hid.val() == '' ? oldElement : ';' + oldElement
                    hid.val(hid.val() + hidText)
                    // inserisco elemento nella lista
                    let list = $(this).parent().parent().siblings('.ele-contiene-list')
                    list.append(
                        '<div class="list-group-item" valoreStringa="' + newElement + '"><span>' + newElement + '</span>' +
                        '<button class="ele-contiene-remove btn btn-danger btn-sm" onclick="removeItemContiene(' +
                        '$(this)' + ')" role="button" type="button">' +
                        '<i class="fa fa-trash" aria-hidden="true"></i>' +
                        '</button>' +
                        '</div>'
                    )
                }
            })
        })
    </script>

    <script>
        function removeItem(el) {
            let hid = $('.ele-noncontiene input[type=hidden]')
            let valoreStringa = el.parent('.list-group-item').attr('valoreStringa')
            if (hid.length > 0 && hid.val() != null) {
                // ottengo un array degli elementi della lista
                listaDati = hid.val().split(';')

                // rimuovo elemento da array
                for (var i = listaDati.length - 1; i >= 0; i--) {
                    if (listaDati[i] === valoreStringa) {
                        listaDati.splice(i, 1)
                        break
                    }
                }

                // aggiorno la input hidden
                hid.val(listaDati.join(';'))

                // eliminazione elemento dalla lista
                $('.ele-noncontiene-list .list-group-item').each(function () {
                    let value = $(this).children('span').text()
                    if (value == valoreStringa) {
                        // elimino la riga
                        $(this).remove()
                    }
                })
            }
        }

        function removeItemEdit(el) {
            let valoreStringa = el.parent('.list-group-item').attr('valoreStringa')
            let hid = $('#valoriNonContiene')
            if (hid.length > 0 && hid.val() != null) {
                // ottengo un array degli elementi della lista
                listaDati = hid.val().split(';')
                // rimuovo elemento da array
                for (var i = listaDati.length - 1; i >= 0; i--) {
                    if (listaDati[i] === valoreStringa) {
                        listaDati.splice(i, 1)
                        break
                    }
                }

                // aggiorno la input hidden
                hid.val(listaDati.join(';'))

                // eliminazione elemento dalla lista
                $('.ele-noncontiene-list .list-group-item').each(function () {
                    let value = $(this).children('span').text()
                    if (value == valoreStringa) {
                        // elimino la riga
                        $(this).remove()
                    }
                })
            }
        }

        function loadListInEdit() {
            // carico hidden con gli elementi dell'elenco
            let loadedHid = $('#valoriNonContiene')

            if (loadedHid && loadedHid.val()) {
                // ottengo un array degli elementi della lista
                let listaDati = loadedHid.val().split(';')

                // visualizzo la lista
                listaDati.forEach(element => {
                    $('.ele-noncontiene-list').append(
                        '<div class="list-group-item" valoreStringa="' + escapeHtml(element) + '"><span>' + element + '</span>' +
                        '<button class="ele-noncontiene-remove btn btn-danger btn-sm" onclick="removeItemEdit(' +
                        '$(this)' + ')" role="button" type="button">' +
                        '<i class="fa fa-trash" aria-hidden="true"></i>' +
                        '</button>' +
                        '</div>'
                    )
                })
            }
        }

        $(document).ready(function () {
            // carico la lista in modifica
            loadListInEdit()

            $('.ele-noncontiene-add').click(function () {
                let edit = $(this).parent().siblings('.ele-noncontiene-edit')
                if (edit.length > 0 && edit.val() != '') {
                    // valore nuovo elemento
                    let oldElement = $.trim(edit.val())
                    let newElement = escapeHtml(oldElement)
                    // pulisco la textbox di input
                    edit.val('')

                    // inserisco elemento nel campo hidden
                    let hid = $(this).parent().parent().siblings('input[type=hidden]')
                    let hidText = hid.val() == '' ? oldElement : ';' + oldElement
                    hid.val(hid.val() + hidText)
                    // inserisco elemento nella lista
                    let list = $(this).parent().parent().siblings('.ele-noncontiene-list')
                    list.append(
                        '<div class="list-group-item" valoreStringa="' + newElement + '"><span>' + newElement + '</span>' +
                        '<button class="ele-noncontiene-remove btn btn-danger btn-sm" onclick="removeItem(' +
                        '$(this)' + ')" role="button" type="button">' +
                        '<i class="fa fa-trash" aria-hidden="true"></i>' +
                        '</button>' +
                        '</div>'
                    )
                }
            })
        })
    </script>

    <script>
        var entityMap = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#39;',
            '/': '&#x2F;',
            '`': '&#x60;',
            '=': '&#x3D;'
        };

        function escapeHtml(string) {
            return String(string).replace(/[&<>"'`=\/]/g, function (s) {
                return entityMap[s];
            });
        }
    </script>

    <!-- Go on top -->
    <script>
        //Get the button
        let mybutton = document.getElementById("btn-back-to-top");

        // When the user scrolls down 20px from the top of the document, show the button
        window.onscroll = function () {
          scrollFunction();
        };

        function scrollFunction() {
          if (
            document.body.scrollTop > 20 ||
            document.documentElement.scrollTop > 20
          ) {
            mybutton.style.display = "block";
          } else {
            mybutton.style.display = "none";
          }
        }
        // When the user clicks on the button, scroll to the top of the document
        mybutton.addEventListener("click", backToTop);

        function backToTop() {
          document.body.scrollTop = 0;
          document.documentElement.scrollTop = 0;
        }
    </script>
</asp:Content>
