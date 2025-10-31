defmodule Pieza do
  defstruct codigo: "", nombre: "", valor: 0, unidad: "", stock: 0


  def crear(codigo, nombre, valor, unidad, stock) do
    %Pieza{codigo: codigo, nombre: nombre, valor: valor, unidad: unidad, stock: stock}
  end


  def escribir_csv(lista, nombre_archivo) do
    contenido =
      Enum.map(lista, fn %Pieza{codigo: c, nombre: n, valor: v, unidad: u, stock: s} ->
        "#{c},#{n},#{v},#{u},#{s}\n"
      end)
      |> Enum.join()

    case File.write(nombre_archivo, contenido) do
      :ok -> :ok
      {:error, reason} -> {:error, reason}
    end
  end


  def leer_csv(nombre_archivo) do
    case File.read(nombre_archivo) do
      {:ok, contenido} ->
        IO.puts("Archivo leído correctamente:\n#{contenido}")
        {:ok, contenido}
      {:error, razon} ->
        {:error, razon}
    end
  end



  def eliminar_duplicados(piezas), do: eliminar_duplicados(piezas, [])

  defp eliminar_duplicados([], _vistos), do: []

  defp eliminar_duplicados([%Pieza{codigo: c} = p | resto], vistos) do
    if contiene?(vistos, c) do
      eliminar_duplicados(resto, vistos)
    else
      [p | eliminar_duplicados(resto, [c | vistos])]
    end
  end


  defp contiene?([], _), do: false
  defp contiene?([h | t], val) when h == val, do: true
  defp contiene?([_ | t], val), do: contiene?(t, val)
end
