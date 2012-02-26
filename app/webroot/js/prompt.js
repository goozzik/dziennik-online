
	function windowYesNo(adress){
		
		//var elem = $(this).closest('.delete_confirm');
		
		$.confirm({
			'title'		: 'Potwierdzenie usunięcia elementu',
			'message'	: 'Czy na pewno chesz usunąć ten element? <br />Nie będzie mógł on przywrócony! Kontynuować?',
			'buttons'	: {
				'Tak'	: {
					'class'	: 'blue',
					'action': function(){
						//elem.slideUp();
						window.location = adress;
						return 1;
					}
				},
				'Nie'	: {
					'class'	: 'gray',
					'action': function(){
						return 0;
					}	// Nothing to do in this case. You can as well omit the action property.
				}
			}
		});
		
	};
	
	
