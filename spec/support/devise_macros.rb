module DeviseMacros
  def sign_in_admin
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:admin)
  end
end
