class Api::V1::FibonaccisController < ApplicationController
  require 'benchmark'

  # GET /fibonaccis
  def index
    @fibos = Fibonacci.last(10).reverse
    render json: @fibos, except: [:id]
  end

  # POST /fibonaccis
  def create
    if params[:n].present?
      if params[:n].instance_of?(Integer)
        @fibo = Fibonacci.new
        value = params[:n].to_i
        @fibo.value = value
        time_s = Benchmark.measure do
          @fibo.result = fibonacci(value)
        end
        # transform to milliseconds
        time_ms = time_s.real * 1000
        @fibo.runtime = time_ms

        if @fibo.save
          render json: @fibo, except: %i[id created_at], status: :created
        else
          render json: @fibo.errors, status: :unprocessable_entity
        end
      else
        render json: { error: 'Wrong value for parameter \'n\', it should be an integer' }, status: :bad_request
      end
    else
      render json: { error: 'Required parameter \'n\' is missing' }, status: :bad_request
    end
  end

  private

  def fibonacci(n)
    f = n < 2 ? n : fibonacci(n - 1) + fibonacci(n - 2)
  end
end
