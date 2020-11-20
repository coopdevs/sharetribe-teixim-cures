class EnableCustomizableFooter < ActiveRecord::Migration[5.2]
  # Note this assumes the external_plan_service_in_use setting is set to true.
  # This migration alone won't enable it.
  def up
    PlanService::Store::Plan::PlanModel.create(
      community_id: community.id,
      status: "active",
      features: {"whitelabel"=>true, "admin_email"=>true, "footer"=>true},
      expires_at: Time.current + 20.years
    )
    community.footer_enabled = true
    community.save!
  end

  def down
    community.footer_enabled = false
    community.save!

    current_plan = PlanService::Store::Plan::PlanModel.where(
      community_id: community.id,
      status: 'active'
    ).first
    current_plan.destroy
  end

  private

  def community
    @community ||= Community.first
  end
end
