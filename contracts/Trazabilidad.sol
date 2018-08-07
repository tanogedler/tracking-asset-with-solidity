pragma solidity ^0.4.23;

/**
 * @title Trazabilidad
 * @dev Contrato con abstraccion de trazabilidad de cadena de suministros
 */
 
contract Trazabilidad {
  /**
  * @dev Definimos la estructura de un producto basico.
  */
  struct Producto {
    string nombre;
    string descripcion;
    string ubicacion;
    string Productor;
    uint32 precioVenta;
    uint256 FechaCreacion;
    bool existe;
  }

  /**
  * @dev Mapeos que define almacenamiento del producto. Usaremos id
  */
  mapping(string  => Producto) private AlmacenamientoProducto;
  mapping(address => mapping(string => bool)) private wallet;


    /**
  * @dev Declaramos los eventos de acuerdo a las operaciones en la cadena:
  */
  event CrearProducto(address direccionProductor, string id, string Productor, uint256 FechaCreacion);
  event TransferenciaProducto(address from, address to, string id);
  //event EstablecerPrecio(string id, uint32 precioVenta);
  event RechazarTransferencia(address from, address to, string id, string mensajeCausaRechazo);
  event RechazarCreacion(address direccionProductor, string id, string mensajeCausaRechazo);

  /**
  * @dev Funcion que crea el producto:
  */
  function creacionProducto(string nombre, string descripcion, string id, string Productor, string ubicacion,  uint32 precioVenta) public {
 
    if(AlmacenamientoProducto[id].existe) {
        emit RechazarCreacion(msg.sender, id, "Producto con este id existe en BD");
        return;
      }
 
      AlmacenamientoProducto[id] = Producto(nombre, descripcion, ubicacion, Productor, precioVenta, now, true);
      wallet[msg.sender][id] = true;
      emit CrearProducto(msg.sender, id, Productor, now);
    }

  /**
  * @dev Funcion para la transferencia del producto:
  */
  function transfProducto(address to, string id) public{
 
    if(!AlmacenamientoProducto[id].existe) {
        emit RechazarTransferencia(msg.sender, to, id, "no existe producto con este id");
        return;
    }
 
    if(!wallet[msg.sender][id]) {
        emit RechazarTransferencia(msg.sender, to, id, "Usuario no posee este producto.");
        return;
    }
 
    wallet[msg.sender][id] = false;
    wallet[to][id] = true;
    emit TransferenciaProducto (msg.sender, to, id);
  }

  /**
  * @dev Funcion para obtener las caracteristicas de un producto:
  */
  function obtenerProducto(string id) public constant returns (string, string, string, string, uint256) {
 
    return (AlmacenamientoProducto[id].nombre, AlmacenamientoProducto[id].descripcion, AlmacenamientoProducto[id].Productor, AlmacenamientoProducto[id].ubicacion, AlmacenamientoProducto[id].precioVenta);
  }

  /**
  * @dev Funcion para verificar la propiedad de un objeto:
  */
  function esPropietario(address propietario, string id) public constant returns (bool) {
 
    if(wallet[propietario][id]) {
        return true;
    }
 
    return false;
  }
}
 