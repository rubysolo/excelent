defmodule Excelent.API.GenerateController do
  use Excelent.Web, :controller
  alias Excelent.Excel

  def generate(conn, params) do
    {:ok, {filename, binary}} = Excel.generate_from(params)

    conn
    |> put_resp_content_type("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    |> put_resp_header("Content-Disposition", ~s<attachment; filename="#{filename}">)
    |> send_resp(200, binary)
  end
end
