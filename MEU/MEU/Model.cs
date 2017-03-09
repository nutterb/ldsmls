using System.Data.Entity;
using System.ComponentModel.DataAnnotations;

namespace EntityFrameworkCF
{
    class CustomerContext : DbContext
    {
        public DbSet Customers { get; set; }
    }

    public class Customer
    {
        [Key]
        public int Id { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Address { get; set; }

        public string City { get; set; }

        public string State { get; set; }

        public int Zip { get; set; }
    }
}
