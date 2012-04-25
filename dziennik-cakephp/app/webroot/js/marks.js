$(document).ready(function() 
{
   $('.title_of_mark').qtip(
   {
		position: {
			corner: {
				target: 'topLeft',
				tooltip: 'bottomLeft'
			}
		},
		style: {
			name: 'cream',
			padding: '7px 13px',
			width: {
				max: 310,
				min: 0
			},
			tip: true
		},
	
		content:  $(this).attr("title")
		
   });
   
   
	
});
