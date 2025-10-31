defmodule Main do
  def main do

    p1 = Pieza.crear("COD128", "LED", 6, "V", 30)
    p2 = Pieza.crear("COD124", "Capacitor", 100, "uF", 35)
    p3 = Pieza.crear("COD125", "LED", 2, "V", 50)
    p4 = Pieza.crear("COD126", "LED", 8, "V", 40)

    list_piezas = [p1, p2, p3, p4]
    IO.puts(" Lista original de piezas")
    IO.inspect(list_piezas)


    Pieza.escribir_csv(list_piezas, "piezas.csv")
    IO.puts("Archivo piezas.csv generado correctamente.")


    m1 = Movimiento.crear("COD128", "SALIDA", 10, "2025-09-12")
    m2 = Movimiento.crear("COD124", "SALIDA", 10, "2025-09-12")
    m3 = Movimiento.crear("COD125", "ENTRADA", 25, "2025-09-15")
    m4 = Movimiento.crear("COD126", "SALIDA", 30, "2025-09-20")

    list_movs = [m1, m2, m3, m4]
    IO.puts("Movimientos registrados")
    IO.inspect(list_movs)


    Movimiento.escribir_csv(list_movs, "movimientos.csv")
    IO.puts("Archivo movimientos.csv generado correctamente.")


    piezas_actualizadas = Inventario.aplicar_movimientos(list_movs, list_piezas)
    IO.puts("\n--- Inventario actualizado ---")
    IO.inspect(piezas_actualizadas)


    piezas_sin_dup = Pieza.eliminar_duplicados(piezas_actualizadas)
    IO.puts("\n--- Inventario sin duplicados ---")
    IO.inspect(piezas_sin_dup)


    total = Movimiento.total_en_rango(list_movs, "2025-09-01", "2025-09-30")
    IO.puts("Total de unidades movidas en septiembre 2025 ")
    IO.puts("#{total} unidades")

  end
end

Main.main()
