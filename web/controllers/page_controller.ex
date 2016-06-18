defmodule Excelent.PageController do
  use Excelent.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
