defmodule Excelent.Excel do
  alias Elixlsx.{Workbook, Sheet}

  @letters ~w( A B C D E F G H I J K L M N O P Q R S T U V W X Y Z )

  def generate_from(%{"filename" => filename, "sheets" => sheets}) do
    Enum.reduce(sheets, %Workbook{}, fn({name, data}, acc) ->
      generate_sheet(acc, name, data)
    end)
    |> Elixlsx.write_to_memory(filename)
  end

  def generate_sheet(workbook, sheet_name, data) do
    Workbook.append_sheet(
      workbook,
      data
      |> Stream.with_index
      |> Enum.reduce(Sheet.with_name(sheet_name), fn({row, row_index}, acc) ->
        row
        |> Stream.with_index
        |> Enum.reduce(acc, fn({cell, col_index}, a) ->
          Sheet.set_cell(a, cell_id(row_index, col_index), cell)
        end)
      end)
    )
  end

  defp cell_id(row_index, col_index) do
    "#{ Enum.at @letters, col_index }#{ row_index + 1 }"
  end
end
