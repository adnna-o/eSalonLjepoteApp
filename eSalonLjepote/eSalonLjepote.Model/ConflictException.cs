using System;
using System.Collections.Generic;
using System.Text;

namespace eSalonLjepote.Model
{
    public class ConflictException : Exception
    {
        public ConflictException(string message) : base(message)
        {
        }
    }
}
