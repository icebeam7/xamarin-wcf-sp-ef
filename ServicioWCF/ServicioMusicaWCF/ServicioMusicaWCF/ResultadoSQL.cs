using System;

namespace ServicioMusicaWCF
{
    [Serializable]
    public class ResultadoSQL
    {
        public int Valor { get; set; }
        public string Mensaje { get; set; }
    }
}