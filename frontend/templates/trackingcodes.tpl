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
