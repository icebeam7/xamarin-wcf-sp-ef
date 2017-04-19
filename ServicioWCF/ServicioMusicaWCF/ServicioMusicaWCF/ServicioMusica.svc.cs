using System;
using System.Linq;
using System.Data.Entity.Core.Objects;
using Newtonsoft.Json;

namespace ServicioMusicaWCF
{
    public class ServicioMusica : IServicioMusica
    {
        public string AgregarArtista(string nombre, string pais)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_AgregarArtista(nombre, pais, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string AgregarCancion(string titulo, string duracion)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_AgregarCancion(titulo, duracion, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string AgregarConcierto(int idArtista, string lugar, DateTime fecha)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_AgregarConcierto(idArtista, lugar, fecha, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string AgregarDetalleConcierto(int idConcierto, int idCancion, int orden)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_AgregarDetalleConcierto(idConcierto, idCancion, orden, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string BuscarArtista(int id)
        {
            using (var conexion = new MusicaEntidades())
            {
                return JsonConvert.SerializeObject(conexion.Procedimiento_BuscarArtista(id).FirstOrDefault());
            }
        }

        public string BuscarCancion(int id)
        {
            using (var conexion = new MusicaEntidades())
            {
                return JsonConvert.SerializeObject(conexion.Procedimiento_BuscarCancion(id).FirstOrDefault());
            }
        }

        public string BuscarConcierto(int id)
        {
            using (var conexion = new MusicaEntidades())
            {
                return JsonConvert.SerializeObject(conexion.Procedimiento_BuscarConcierto(id).FirstOrDefault());
            }
        }

        public string EliminarArtista(int id)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_EliminarArtista(id, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string EliminarCancion(int id)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_EliminarCancion(id, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string EliminarConcierto(int id)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_EliminarConcierto(id, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string EliminarDetalleConcierto(int idConcierto, int idCancion)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_EliminarDetalleConcierto(idConcierto, idCancion, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string ModificarArtista(int id, string nombre, string pais)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_ModificarArtista(id, nombre, pais, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string ModificarCancion(int id, string titulo, string duracion)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_ModificarCancion(id, titulo, duracion, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string ModificarConcierto(int id, int idArtista, string lugar, DateTime fecha)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_ModificarConcierto(id, idArtista, lugar, fecha, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string ModificarDetalleConcierto(int idConcierto, int idCancion, int orden)
        {
            int valor;
            var mensaje = new ObjectParameter("mensaje", typeof(string));

            using (var conexion = new MusicaEntidades())
            {
                valor = conexion.Procedimiento_ModificarDetalleConcierto(idConcierto, idCancion, orden, mensaje);
                return JsonConvert.SerializeObject(new ResultadoSQL() { Valor = valor, Mensaje = mensaje.Value.ToString() });
            }
        }

        public string ObtenerArtistas()
        {
            using (var conexion = new MusicaEntidades())
            {
                return JsonConvert.SerializeObject(conexion.Procedimiento_ObtenerArtistas().ToList());
            }
        }

        public string ObtenerCanciones()
        {
            using (var conexion = new MusicaEntidades())
            {
                return JsonConvert.SerializeObject(conexion.Procedimiento_ObtenerCanciones().ToList());
            }
        }

        public string ObtenerConciertos()
        {
            using (var conexion = new MusicaEntidades())
            {
                return JsonConvert.SerializeObject(conexion.Procedimiento_ObtenerConciertos().ToList());
            }
        }

        public string ObtenerDetallesConcierto(int idConcierto)
        {
            using (var conexion = new MusicaEntidades())
            {
                return JsonConvert.SerializeObject(conexion.Procedimiento_ObtenerDetallesConcierto(idConcierto).ToList());
            }
        }
    }
}