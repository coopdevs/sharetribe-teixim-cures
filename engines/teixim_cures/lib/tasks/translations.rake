# rubocop:disable Metrics/LineLength
namespace :translations do
  COMMUNITY_ID = 1

  desc "Override translations with community customizations"
  task override: :environment do
    # Define translations by calling #transalte. For example:
    #
    #  translate(locale: 'es', key: 'listings.listing_actions.marketplace_fees_may_apply', value: "%{service_name} aplica una cuota de servicio por transacción que contribuye a mantener la plataforma")
    #  translate(locale: 'ca', key: 'listings.listing_actions.marketplace_fees_may_apply', value: "%{service_name} aplica una quota de servei per transacció que contribueix a mantenir la plataforma")
    #
    translate(locale: 'es', key: 'customization.out_of_stock', value: "Este item está fuera de stock.")
    translate(locale: 'ca', key: 'customization.out_of_stock', value: "Aquest item està fora d'estoc.")

    translate(locale: 'es', key: 'admin.transaction_types.default_action_button_labels.offer', value: "Contacta")
    translate(locale: 'ca', key: 'admin.transaction_types.default_action_button_labels.offer', value: "Contacta")
    
  end

  def translate(locale:, key:, value:)
    attrs = { locale: locale, translation: value }
    TranslationServiceHelper.translation_hashes_to_tr_key!([attrs], COMMUNITY_ID, key)
  end
end
# rubocop:enable Metrics/LineLength
