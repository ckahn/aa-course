module ApplicationHelper
  def success?(model, method)
    model.send(method) ? render(json: model) : show_error(model)
  end

  def show_error(model)
    render json: model.errors.full_messages, status: :unprocessable_entity
  end
end
