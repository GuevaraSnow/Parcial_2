defmodule Inventario do
  def aplicar_movimientos([], piezas), do: piezas

  def aplicar_movimientos([mov | resto_movs], piezas) do
    piezas_actualizadas = actualizar_pieza(piezas, mov)
    aplicar_movimientos(resto_movs, piezas_actualizadas)
  end


  defp actualizar_pieza([], _mov), do: []


  defp actualizar_pieza([%Pieza{codigo: c} = pieza | resto], %Movimiento{codigo: c, tipo: tipo, cantidad: cant}) do
    nueva_stock =
      case tipo do
        "ENTRADA" -> pieza.stock + cant
        "SALIDA" -> pieza.stock - cant
        _ -> pieza.stock
      end

    [%Pieza{pieza | stock: nueva_stock} | resto]
  end


  defp actualizar_pieza([pieza | resto], mov) do
    [pieza | actualizar_pieza(resto, mov)]
  end


  def guardar_inventario(nombre_archivo, piezas) do
    Pieza.escribir_csv(piezas, nombre_archivo)
  end
end
