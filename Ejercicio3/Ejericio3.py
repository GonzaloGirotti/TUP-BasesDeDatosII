import threading
import pymysql
import time

def retirar(nombre):
    try:
        conn = pymysql.connect(
            host="localhost",
            user="GonzaloGirotti",
            password="3Lc0l050*",
            database="BasesDeDatosDB",
            autocommit=False
        )
        with conn.cursor() as cursor:
            print(f"[{nombre}] Iniciando transacción")
            #la otra opcion es SERIALIZABLE
            cursor.execute("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;")
            cursor.execute("START TRANSACTION;")
            #probar quitando for update
            cursor.execute("SELECT saldo FROM cuentas WHERE id = 1;")
            saldo = cursor.fetchone()[0]
            print(f"[{nombre}] Saldo leído: {saldo}")

            #time.sleep(2)

            nuevo_saldo = saldo - 100
            cursor.execute("UPDATE cuentas SET saldo = %s WHERE id = 1;", (nuevo_saldo,))
            conn.commit()
            print(f"[{nombre}] Commit realizado. Nuevo saldo: {nuevo_saldo}")
    except Exception as e:
        print(f"[{nombre}] Error: {e}")
        conn.rollback()
    finally:
        conn.close()

# Ejecutar los dos hilos
t1 = threading.Thread(target=retirar, args=("Usuario A",))
t2 = threading.Thread(target=retirar, args=("Usuario B",))

t1.start()
t2.start()
t1.join()
t2.join()