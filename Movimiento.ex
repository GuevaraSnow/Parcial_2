defmodule Movimiento do
  defstruct codigo: "", tipo: "", cantidad: 0, fecha: ""


  def crear(codigo, tipo, cantidad, fecha) do
    %Movimiento{codigo: codigo, tipo: tipo, cantidad: cantidad, fecha: fecha}
  end

  # escribir movimientos a CSV
  def escribir_csv(lista, nombre_archivo) do
    contenido =
      Enum.map(lista, fn %Movimiento{codigo: c, tipo: t, cantidad: cant, fecha: f} ->
        "#{c},#{t},#{cant},#{f}\n"
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


  def total_en_rango([], _ini, _fin), do: 0

  def total_en_rango([%Movimiento{fecha: f, cantidad: c} | resto], ini, fin) do
    if f >= ini and f <= fin do
      c + total_en_rango(resto, ini, fin)
    else
      total_en_rango(resto, ini, fin)
    end
  end
end
