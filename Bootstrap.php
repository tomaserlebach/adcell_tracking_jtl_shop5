<?php declare(strict_types=1);
namespace Plugin\adcell_tracking_jtl_shop5;

use JTL\Alert\Alert;
use JTL\Catalog\Category\Kategorie;
use JTL\Catalog\Product\Artikel;
use JTL\Consent\Item;
use JTL\Events\Dispatcher;
use JTL\Events\Event;
use JTL\Helpers\Form;
use JTL\Helpers\Request;
use JTL\Link\LinkInterface;
use JTL\Plugin\Bootstrapper;
use JTL\Shop;
use JTL\Smarty\JTLSmarty;


/**
 * Class Bootstrap
 * @package Plugin\adcell_tracking_jtl_shop5
 */
class Bootstrap extends Bootstrapper
{
    private const CONSENT_ITEM_ID = 'adcell_tracking';

    /**
     * }
     * @inheritdoc
     */
    public function boot(Dispatcher $dispatcher)
    {
        $plugin = $this->getPlugin();
        $db     = $this->getDB();
        $cache  = $this->getCache();
        $smarty = Shop::Smarty();

        parent::boot($dispatcher);

        $state = Shop::Container()->getConsentManager()->hasConsent(self::CONSENT_ITEM_ID);
        if ($state !== true) {
            return false;
        }

        $dispatcher->listen('shop.hook.' . \HOOK_BESTELLABSCHLUSS_PAGE, function ($args) use ($plugin, $smarty) {

            $order_number = $args['oBestellung']->cBestellNr;
            $sum = $args['oBestellung']->fGesamtsumme;
            $programm_id = $plugin->getConfig()->getValue('programId');
            $event_id = $plugin->getConfig()->getValue('eventId');
            $smarty->assign('order', $args['oBestellung']);

            $smarty->assign('order_complete', true);
        });

        $dispatcher->listen('shop.hook.' . \HOOK_SMARTY_OUTPUTFILTER, function ($args) use ($plugin, $smarty) {
            $smarty->assign('adcell_program_id', $plugin->getConfig()->getValue('programId'));
            $smarty->assign('adcell_event_id', $plugin->getConfig()->getValue('eventId'));

            pq('body')->append($smarty->fetch($plugin->getPaths()->getFrontendPath() . 'templates/trackingcodes.tpl'));
        });
    }
}
