require 'spec_helper'

module Spree
  module Hub
    describe Handler::AddProductHandler do

      context "#process" do
        context "with a master product (ie no parent_id)" do

          let!(:message) do
            hsh = ::Hub::Samples::Product.request
            hsh["product"]["parent_id"] = nil
            hsh
          end

          let(:handler) { Handler::AddProductHandler.new(message.to_json) }

          it "imports a new product in the storefront" do
            expect{handler.process}.to change{Spree::Product.count}.by(1)
          end

          it "imports a new variant master in the storefront" do
            expect{handler.process}.to change{Spree::Variant.count}.by(1)
          end

          context "response" do
            let(:responder) { handler.process }

            it "is a Hub::Responder" do
              expect(responder.class.name).to eql "Spree::Hub::Responder"
            end

            it "returns the original request_id" do
              expect(responder.request_id).to eql message["request_id"]
            end

            it "returns http 200" do
              expect(responder.code).to eql 200
            end

            it "returns a summary with the created product and variant id's" do
              expect(responder.summary).to match /Product \(\d\) and master variant \(\d\) are added/
            end
          end

        end
      end

    end
  end
end