# frozen_string_literal: true

module Api::V1
  class LoansController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_user_loan, only: [:show, :update]

    # GET /users/:user_id/loans
    def index
      json_response @user.loans.includes(:movies).references(:movies).order(updated_at: :desc)
    end

    # GET /users/:user_id/loans/id
    def show
      json_response(@loan)
    end

    # POST /users/:user_id/loans
    def create
      @loan = Loan.create!(create_loan_params)
      json_response(@loan, :created)
    end

    # PUT /users/:user_id/loans/:id
    def update
      @loan.update!(update_loan_params)
      json_response(@loan, :ok)
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_user_loan
      @loan = @user.loans.find_by!(id: params[:id]) if @user
    end

    def create_loan_params
      params.permit(:user_id, movie_ids: [])
    end

    def update_loan_params
      params.permit(:user_id, :status)
    end
  end
end
