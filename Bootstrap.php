<?php declare(strict_types=1);
namespace Plugin\adcell_tracking_jtl_shop5;

use JTL\Events\Dispatcher;
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
        $smarty = Shop::Smarty();
        $pageType = Shop::getPageType();

        parent::boot($dispatcher);

        $dispatcher->listen('shop.hook.' . \HOOK_BESTELLABSCHLUSS_PAGE, function ($args) use ($plugin, $smarty) {
            $smarty->assign('order', $args['oBestellung']);

            $smarty->assign('order_complete', true);
        });

        /* Homepage */
        $dispatcher->listen('shop.hook.' . \HOOK_SEITE_PAGE, function ($args) use ($plugin, $smarty) {

            $currentPage = str_replace('?'.$_SERVER['QUERY_STRING'], '', $_SERVER['REQUEST_URI']);

            if($currentPage === '/') {
                $smarty->assign('adcell_is_homepage', true);
            }
        });

        /* Category Page */
        $dispatcher->listen('shop.hook.' . \HOOK_FILTER_ENDE, function ($args) use ($plugin, $smarty) {
            #die(var_dump($args));
            $smarty->assign('adcell_is_categorypage', true);

        });

        /* Product Page */
        $dispatcher->listen('shop.hook.' . \HOOK_ARTIKEL_PAGE, function ($args) use ($plugin, $smarty, $pageType) {

                $smarty->assign('adcell_is_productpage', true);

        });

        /* Search Page */
        $dispatcher->listen('shop.hook.' . \HOOK_NAVI_SUCHE, function ($args) use ($plugin, $smarty, $pageType) {

                $smarty->assign('adcell_is_search', true);

        });

        /* Basket */
        $dispatcher->listen('shop.hook.' . \HOOK_WARENKORB_PAGE, function ($args) use ($plugin, $smarty, $pageType) {

            $smarty->assign('adcell_is_basket', true);

        });

        /* Checkout */
        $dispatcher->listen('shop.hook.' . \HOOK_BESTELLVORGANG_PAGE, function ($args) use ($plugin, $smarty, $pageType) {

                $smarty->assign('adcell_is_checkout', true);

        });

        $dispatcher->listen('shop.hook.' . \HOOK_SMARTY_OUTPUTFILTER, function ($args) use ($plugin, $smarty) {

            $state = Shop::Container()->getConsentManager()->hasConsent(self::CONSENT_ITEM_ID);
            if ($state !== true) {
                return false;
            }

            $smarty->assign('adcell_program_id', $plugin->getConfig()->getValue('programId'));
            $smarty->assign('adcell_event_id', $plugin->getConfig()->getValue('eventId'));#

            pq('body')->append($smarty->fetch($plugin->getPaths()->getFrontendPath() . 'templates/trackingcodes.tpl'));
        });
    }
}
