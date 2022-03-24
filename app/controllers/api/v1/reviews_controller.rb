module Api
    module V1
        class ReviewsController < ApplicationController

            protect_from_forgery with: :null_session

            def index
                reviews = Review.all
                render json: ReviewSerializer.new(review).serialized_json
              end

        def create
            review = airline.reviews.new(review_params)
                if review.save
                    render json: ReviewSerializer.new(review).serialized_json
                else
                    render json:{error: review.errors.messages}, status: 422
            end
        end

        def destroy
            review = Review.find(params[:id])
                if review.destroy
                    head :no_content
                else
                    render json:{error: review.errors.messages}, status: 422
            end
        end

        private

        def review_params
            params.require(:review).permit(:title, :description, :score, :airline_id)
        end

        def airline
            @airline ||= Airline.find(params[:airline_id])
        end

        end
    end
end

# module Api
#     module V1
#       class ReviewsController < ApplicationController
#         # before_action :authenticate
  
#         # POST /api/v1/reviews
#         def create
#           review = current_user.reviews.new(review_params)
  
#           if review.save
#             render json: serializer(review)
#           else
#             render json: errors(review), status: 422
#           end
#         end
  
#         # DELETE /api/v1/reviews/:id
#         def destroy
#           review = current_user.reviews.find(params[:id])
  
#           if review.destroy
#             head :no_content
#           else
#             render json: errors(review), status: 422
#           end
#         end
  
#         private
  
#         # Strong params
#         def review_params
#           params.require(:review).permit(:title, :description, :score, :airline_id)
#         end
  
#         # fast_jsonapi serializer
#         def serializer(records, options = {})
#           ReviewSerializer
#             .new(records, options)
#             .serialized_json
#         end
  
#         def errors(record)
#           { errors: record.errors.messages }
#         end
#       end
#     end
#   end