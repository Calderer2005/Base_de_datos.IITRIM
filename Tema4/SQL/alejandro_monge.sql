SELECT PRODUCTOS.NOMBRE FROM PRODUCTOS,OFERTAS WHERE PRODUCTOS.CODIGO = OFERTAS.PRODUCTO AND OFERTAS.INICIO = 'SEPTIEMBRE';
SELECT PRODUCTOS.NOMBRE FROM PRODUCTOS, TIENDAS, OFERTAS WHERE PRODUCTOS.CODIGO = OFERTAS.PRODUCTO AND TIENDAS.CODIGO = OFERTAS.TIENDA AND TIENDAS.METROS > 500;
SELECT PRODUCTOS.NOMBRE FROM PRODUCTOS,OFERTAS,TIENDAS,TRABAJADOR WHERE PRODUCTOS.CODIGO = OFERTAS.PRODUCTO AND TIENDAS.CODIGO = OFERTAS.TIENDA AND TIENDAS.CODIGO = TRABAJADOR.TIENDA AND TRABAJADOR.PROVINCIA ='GRANADA';
SELECT PRODUCTOS.NOMBRE, PRODUCTOS.PRECIO FROM PRODUCTOS,OFERTAS WHERE OFERTAS.PRODUCTOS = PRODUCTOS.COD AND OFERTAS.TIPO = 2;
SELECT COMPRAS.* FROM CLIENTES,PRODUCTOS,COMPRAS  WHERE CLIENTES.DNI = COMPRAS.CLIENTE AND PRODUCTOS.COD = COMPRAS.PRODUCTO ORDER BY FEC_NAC ASC;
SELECT CLIENTES.DIRECCION FROM CLIENTES,COMPRAS,PRODUCTOS WHERE CLIENTES.DNI = COMPRAS.CLIENTE AND PRODUCTOS.CODIGO = COMPRAS.PRODUCTO AND COMPRAS.PRODUCTO = 8 AND PRODUCTOS.NOMBRE = 'BOLIGRAFO AZUL';
SELECT TIENDAS.COD FROM TIENDAS,PRODUCTOS,OFERTAS WHERE PRODUCTOS.COD = OFERTAS.PRODUCTO AND OFERTAS.TIENDA = TIENDAS.COD AND PRODUCTOS.PRECIO IS NULL;
SELECT PRODUCTOS.PRECIO, PRODUCTOS.NOMBRE FROM PRODUCTOS,OFERTAS WHERE OFERTAS.PRODUCTO = PRODUCTOS.COD AND OFERTAS.TIPO = 2;
SELECT CLIENTES.* FROM CLIENTES,COMPRAS,PRODUCTOS WHERE PRODUCTOS.COD = COMPRAS.PRODUCTO AND COMPRAS.CLIENTE = CLIENTES.DNI AND PRODUCTOS.NOMBRE = 'BOLIGAFO AZUL' ORDER BY FEC_NAC ASC;
SELECT CLIENTES.NOMBRE FROM CLIENTES,PRODUCTOS,COMPRAS WHERE CLIENTES.DNI = COMPRAS.CLIENTE AND PRODUCTOS.COD = COMPRAS.PRODUCTO AND PRODUCTOS.PRECIO IS NOT NULL;
SELECT COMPRAS.CANTIDAD FROM CLIENTES,COMPRAS WHERE CLIENTES.DNI = COMPRAS.CLIENTE WHERE CLIENTES.DIRECCION = 'MALAGA';
SELECT OFERTAS.*, TRABAJADORES.NOMBRE,PRODUCTOS.NOMBRE FROM TIENDAS,OFERTAS,PRODUCTOS,TRABAJADORES WHERE TIENDAS.CODIGO = OFERTAS.TIENDA AND TRABAJADORES.TIENDA = TIENDAS.COD AND PRODUCTOS.COD = OFERTAS.PRODUCTO AND TIENDAS.METROS >500;
SELECT CLIENTES.DIRECCION FROM CLIENTES,COMPRAS,PRODUCTOS WHERE PRODUCTOS.COD = COMPRAS.PRODUCTO AND CLIENTES.DNI = COMPRAS.CLIENTE AND PRODUCTOS.PRECIO IS NOT NULL;
SELECT PRODUCTOS.NOMBRE, PRODUCTOS.PRECIO FROM PRODUCTOS,OFERTAS,TRABAJADORES WHERE PRODUCTOS.COD = OFERTAS.PRODUCTO AND TRABAJADORES.COD = OFERTAS.TRABAJADOR AND OFERTAS.TRABAJADOR IS NULL;
SELECT PRODUCTS.NOMBRE FROM PRODUCTOS,OFERTAS WHERE PRODUCTOS.COD = OFERTAS.PRODUCTO WHERE OFERTAS.INICIO = 01/05/2024 OR OFERTAS.INICIO = 01/06/2024;