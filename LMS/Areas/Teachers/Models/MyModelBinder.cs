using Microsoft.AspNetCore.Mvc.ModelBinding;
using System.Threading.Tasks;

namespace LMS.Areas.Teachers.Models
{
    public class MyModelBinder : IModelBinder
    {
        public Task BindModelAsync(ModelBindingContext bindingContext)
        {
            // whatever model binding you need to do
            bindingContext.Result = ModelBindingResult.Success(new Test());

            return Task.CompletedTask;
        }
    }
}
