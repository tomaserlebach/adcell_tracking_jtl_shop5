{strip}
<script type="text/javascript" src="https://t.adcell.com/js/trad.js"></script><script>Adcell.Tracking.track();</script>
{if $order_complete == true}
    <script type="text/javascript" src="https://t.adcell.com/t/track.js?pid={$adcell_program_id}&eventid={$adcell_event_id}&referenz={$order->cBestellNr}&betrag={$order->fGesamtsumme}" async> </script>
    <noscript><img border="0" width="1" height="1" src="https://t.adcell.com/t/track?pid={$adcell_program_id}&eventid={$adcell_event_id}&referenz={$order->cBestellNr}&betrag={$order->fGesamtsumme}"></noscript>
{/if}
{/strip}
