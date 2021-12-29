{strip}
<!-- ADCELL Tracking Script -->
<script type="text/javascript" src="https://t.adcell.com/js/trad.js"></script><script>Adcell.Tracking.track();</script>
{if $order_complete == true}
    <!-- ADCELL Order Complete Script -->
    <script type="text/javascript" src="https://t.adcell.com/t/track.js?pid={$adcell_program_id}&eventid={$adcell_event_id}&referenz={$order->cBestellNr}&betrag={$order->fWarensummeNetto|string_format:"%.2f"}" async> </script>
    <noscript><img border="0" width="1" height="1" src="https://t.adcell.com/t/track?pid={$adcell_program_id}&eventid={$adcell_event_id}&referenz={$order->cBestellNr}&betrag={$order->fWarensummeNetto|string_format:"%.2f"}"></noscript>
{/if}
{/strip}

{if $adcell_is_homepage == true}
    <!-- ADCELL Retargeting Homepage Script -->
    <script type="text/javascript" src="https://t.adcell.com/js/inlineretarget.js?method=track&pid={$adcell_program_id}&type=startpage" async></script>
{/if}

{if $adcell_is_categorypage == true}
    {assign var=roleAdcellProductsString value=""}
    {foreach from=$Suchergebnisse->getProducts() item=article}
        {if $roleAdcellProductsString === ''}
            {assign var=roleAdcellProductsString value="{$article->cArtNr}"}
        {else}
            {assign var=roleAdcellProductsString value="{$roleAdcellProductsString};{$article->cArtNr}"}
        {/if}
    {/foreach}
    <!-- ADCELL Retargeting Category Page Script -->
    <script type="text/javascript" src="https://t.adcell.com/js/inlineretarget.js?method=category&pid={$adcell_program_id}&categoryName={if $AktuelleKategorie->cName|mb_detect_encoding:'UTF-8' === 'UTF-8'}{$AktuelleKategorie->cName}{else}{$AktuelleKategorie->cName|utf8_encode}{/if}&categoryId={$AktuelleKategorie->kKategorie}&productIds={$roleAdcellProductsString}&productSeparator=;" async></script>
{/if}

{if $adcell_is_productpage == true}
    {assign var=roleAdcellProductsString value=""}
    {foreach from=$Artikel->similarProducts->oArtikelArr item=article}
        {if $roleAdcellProductsString === ''}
            {assign var=roleAdcellProductsString value="{$article->cArtNr}"}
        {else}
            {assign var=roleAdcellProductsString value="{$roleAdcellProductsString};{$article->cArtNr}"}
        {/if}
    {/foreach}

    <!-- ADCELL Retargeting Product Page Script -->
    <script type="text/javascript" src="https://t.adcell.com/js/inlineretarget.js?method=product&pid={$adcell_program_id}&productId={$Artikel->kArtikel}&productName={if $Artikel->cName|mb_detect_encoding:'UTF-8' === 'UTF-8'}{$Artikel->cName}{else}{$Artikel->cName|utf8_encode}{/if}&categoryId={$AktuelleKategorie->kKategorie}&productIds={$roleAdcellProductsString}&productSeparator=;" async></script>
{/if}

{if $adcell_is_search == true}
    <!-- ADCELL Retargeting Search Page Script -->
    <script type="text/javascript" src="https://t.adcell.com/js/inlineretarget.js?method=search&pid={$adcell_program_id}&search={if $NaviFilter->EchteSuche->cSuche|mb_detect_encoding:'UTF-8' === 'UTF-8'}{$NaviFilter->EchteSuche->cSuche}{else}{$NaviFilter->EchteSuche->cSuche|utf8_encode}{/if}&productIds={$roleAdcellProductsString}&productSeparator=;"></script>
{/if}

{if $adcell_is_basket == true}
    <!-- ADCELL Retargeting Basket Script -->

        {assign var=roleAdcellProductsString value=""}
        {assign var=roleAdcellQuantitiesString value=""}
        {assign var=roleAdcellQuantityNumber value=0}
        {assign var=roleAdcellCartAmount value=0.0}
        {if isset($Warenkorb)}
            {assign var=roleAdcellCartPositions value=$Warenkorb->PositionenArr}
        {else}
            {assign var=roleAdcellCartPositions value=$smarty.session.Warenkorb->PositionenArr}
        {/if}
        {foreach from=$roleAdcellCartPositions item=article}
            {if $roleAdcellProductsString === ''}
                {if $article->kArtikel > 0}
                    {assign var=roleAdcellProductsString value="{$article->cArtNr}"}
                    {assign var=roleAdcellQuantitiesString value="{$article->nAnzahl}"}
                    {assign var=roleAdcellQuantityNumber value=$article->nAnzahl}
                    {assign var=roleAdcellCartAmount value=$article->nAnzahl*$article->fPreisEinzelNetto}
                {/if}
            {else}
                {if $article->kArtikel > 0}
                    {assign var=roleAdcellProductsString value="{$roleAdcellProductsString};{$article->cArtNr}"}
                    {assign var=roleAdcellQuantitiesString value="{$roleAdcellQuantitiesString};{$article->nAnzahl}"}
                    {assign var=roleAdcellQuantityNumber value=$roleAdcellQuantityNumber+$article->nAnzahl}
                    {assign var=roleAdcellCartAmount value=$roleAdcellCartAmount+($article->nAnzahl*$article->fPreisEinzelNetto)}

                {/if}
            {/if}
        {/foreach}
    <script type="text/javascript" src="https://t.adcell.com/js/inlineretarget.js?method=basket&pid={$adcell_program_id}&productIds={$roleAdcellProductsString}&productSeparator=;&quantities={$roleAdcellQuantitiesString}&basketProductCount={$roleAdcellQuantityNumber}&basketTotal={$roleAdcellCartAmount}" async></script>
{/if}

{if $adcell_is_checkout == true}
    {assign var=roleAdcellProductsString value=""}
    {assign var=roleAdcellQuantitiesString value=""}
    {assign var=roleAdcellQuantityNumber value=0}
    {assign var=roleAdcellCartAmount value=0.0}
    {foreach from=$smarty.session.Warenkorb->PositionenArr item=article}
        {if $roleAdcellProductsString === ''}
            {if $article->kArtikel > 0}
                {assign var=roleAdcellProductsString value="{$article->cArtNr}"}
                {assign var=roleAdcellQuantitiesString value="{$article->nAnzahl}"}
                {assign var=roleAdcellQuantityNumber value=$article->nAnzahl}
                {assign var=roleAdcellCartAmount value=$article->nAnzahl*$article->fPreisEinzelNetto}
            {/if}
        {else}
            {if $article->kArtikel > 0}
                {assign var=roleAdcellProductsString value="{$roleAdcellProductsString};{$article->cArtNr}"}
                {assign var=roleAdcellQuantitiesString value="{$roleAdcellQuantitiesString};{$article->nAnzahl}"}
                {assign var=roleAdcellQuantityNumber value=$roleAdcellQuantityNumber+$article->nAnzahl}
                {assign var=roleAdcellCartAmount value=$roleAdcellCartAmount+($article->nAnzahl*$article->fPreisEinzelNetto)}
            {/if}
        {/if}
    {/foreach}
    <!-- ADCELL Retargeting Checkout Page Script -->
    <script type="text/javascript" src="https://t.adcell.com/js/inlineretarget.js?method=checkout&pid={$adcell_program_id}&basketId={$Bestellung->cBestellNr}&basketTotal={$roleAdcellCartAmount}&basketProductCount={$roleAdcellQuantityNumber}&productIds={$roleAdcellProductsString}&productSeparator=;&quantities={$roleAdcellQuantitiesString}" async></script>
{/if}
