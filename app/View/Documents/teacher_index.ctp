<span class="title">Dokumenty</span></br></br>
<?php if(!empty($files)){
	echo '<table>';
		echo '<tr>';
			echo '<th style="min-width:100px;">Nazwa pliku</th>';
			echo '<th>Opis</th>';
			echo '<!--<th>Typ</th>-->';
			echo '<th style="min-width:120px;">Data dodania</th>';
			echo '<th></th>';
			echo '<th></th>';
		echo '</tr>';
		foreach($files as $file){
		
		echo '<tr>';
			echo '<td>'.$file['Document']['name'].'</td>';
			echo '<td>'.$file['Document']['description'].'</td>';
			echo '<!--<td>'.$file['Document']['type'].'</td>-->';
			echo '<td align="center">'.$file['Document']['date'].'</td>';
			echo '<td><a href="'.$file['Document']['path'].'">Pobierz<a/></td>';
			echo '<td><a href="documents/delete/'.$file['Document']['id'].'">Usuń<a/></td>';
		echo '</tr>';
		}
	echo '</table></br></br>';
}

?>
<span class="title">Dodaj nowy plik do klasy</span>
	
<?php echo $this->Form->create('Document', array('action'=>'add','enctype' => 'multipart/form-data') );?>
<table style="width:410px;">
	<tr><td>Wybierz plik:</td><td><?php echo $this->Form->input('file', array('label'=>'','type'=>'file', 'style'=>'width:300px'));?></td></tr>
	<tr><td>Opis pliku:</td><td><?php echo $this->Form->input('description', array('label'=>'','type'=>'text', 'style'=>'width:300px;height:30px;'));?></td></tr>
	<tr><td align="center" colspan="2"><?php echo $this->Form->end('Dodaj nowy plik');?></td></tr>
</table>
