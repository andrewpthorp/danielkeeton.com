require 'spec_helper'

describe InquiriesController do
  describe InquiriesController::InquiryParams do
    let (:hash) { { inquiry: { inquiry_type: 'homeworth' } } }
    let (:params) { ActionController::Parameters.new(hash) }
    let (:blank_params) { ActionController::Parameters.new({}) }

    it 'scrubs the parameters' do
      inquiry_params = InquiriesController::InquiryParams.build(params)
      expect(inquiry_params).to eq({'inquiry_type' => 'homeworth'})
    end

    it 'requires a inquiry' do
      expect { InquiriesController::InquiryParams.build(blank_params) }.to(
        raise_error(ActionController::ParameterMissing, /inquiry/)
      )
    end
  end

  describe 'POST create' do

    context 'when creating succeeds' do
      before do
        Inquiry.any_instance.stub(:save).and_return(true)
      end

      it 'should set the flash' do
        post :create, { inquiry: { inquiry_type: 'homeworth' } }
        expect(flash[:success]).to match(/received your message/)
      end
    end

    context 'when creating fails' do
      before do
        Inquiry.any_instance.stub(:save).and_return(false)
      end

      it 'should set the flash' do
        post :create, { inquiry: { inquiry_type: 'homeworth' } }
        expect(flash[:error]).to match(/error sending your message/)
      end
    end

    it 'should redirect to the root' do
      post :create, { inquiry: { inquiry_type: 'homeworth' } }
      expect(response).to redirect_to(root_path)
    end
  end
end
