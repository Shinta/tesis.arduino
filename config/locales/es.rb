# encoding: utf-8
{
  :es => {
    
    :config => {
      :site_title => "Inmuebles Inteligentes",
      :language_iso => "es",
      :faye_server => "192.168.1.101",
      :server_host => "192.168.1.101",
      :server_port => "3000",
      :main_alarm_code => "alarma"
    },
    
    :main_alarm => {
      :arduino_code => "alarma",
      :descriptions => {
        :fire => "Se detecto <strong>FUEGO</strong>.",
        :intrusion => "Se detecto <strong>INTRUSION</strong> en el perimetro.",
        :temperature => "Se detecto <strong>ALTA TEMPERATURA</strong> de %{value} C.",
        :turned_off => "La Alarma Principal ha sido apagada.",
        :children_room_movement => "Se detecto movimiento en la Pieza de los Niños."
      }
    },
    
    :date => {
      :formats => {
        :default => "%d/%m/%Y", 
        :short => "%d de %B", 
        :long => "%d de %B de %Y"
      },
      :day_names => %w{Domingo Lunes Martes Miércoles Jueves Viernes Sábado},
      :abbr_day_names => %w{Dom Lun Mar Mié Jue Vie Sáb},
      :month_names => [nil] + %w{Enero Febrero Marzo Abril Mayo Junio Julio Agosto Setiembre Octubre Noviembre Diciembre},
      :abbr_month_names => [nil] + %w{Ene Feb Mar Abr May Jun Jul Ago Set Oct Nov Dic},
      :order => [:day, :month, :year]
    },
    :time => {
      :formats => {
        :default => "%A, %d de %B de %Y, %H:%M h", 
        :short => "%d/%m, %H:%M h", 
        :long => "%d de %B de %Y"
      },
      :am => '',
      :pm => ''
    },

    # Array.to_sentence
    :support => {
      :array => {:words_connector => ", ", :two_words_connector => " e ", :last_word_connector => " e "},
      :select => {:prompt => "Por favor seleccione"}
    },

    :number => {
      :format => {:separator => ',', :delimiter => '.', :precision => 3, :significant => false, :strip_insignificant_zeros => false},
      :currency => {
        :format => {:format => '%u%n', :unit => '$ ', :separator => ',', :delimiter => '.', :precision => 2, :significant => false, :strip_insignificant_zeros => true}
      },
      :percentage => {
        :format => {:delimiter => '.'}
      },
      :precision => {
        :format => {:delimiter => '.'}
      },
      :human => {
        :format => {:delimiter => '.', :precision => 2, :significant => true, :strip_insignificant_zeros => true}
      },
      :storage_units => {
        :format => "%n %u",
        :units => {
          :byte => {:one => "Byte", :other => "Bytes"},
          :kb => "KB",
          :mb => "MB",
          :gb => "GB",
          :tb => "TB"
        }
      },
      # number_to_human()      
      :decimal_units => {
        :format => "%n %u",
        :units => {
          :unit => "",
          :thousand => "mil",
          :million => {:one => "millón", :other => "millones"},
          :billion => {:one => "billón", :other => "billones"},
          :trillion => {:one => "trillón", :other => "trillones"},
          :quadrillion => {:one => "quatrillón", :other => "quatrillones"}
        }
      },
      :text => {
        :one => "un", :one => "un", :two => "dos", :three => "tres", :four => "cuatro", :five => "cinco", :six => "seis", :seven => "siete", :eight => "ocho", :nine => "nueve", :ten => "diez"
      }
    },

    # distancia do tempo em palavras
    :datetime => {
      :distance_in_words => {
        :half_a_minute => 'medio minuto',
        :less_than_x_seconds => {:one => 'menos de 1 segundo', :other => 'menos de %{count} segundos'},
        :x_seconds => {:one => '1 segundo', :other => '%{count} segundos'},
        :less_than_x_minutes => {:one => 'menos de un minuto', :other => 'menos de %{count} minutos'},
        :x_minutes => {:one => '1 minuto', :other => '%{count} minutos'},
        :about_x_hours => {:one => 'aprox. 1 hora', :other => 'aprox. %{count} horas'},
        :x_days => {:one => '1 dia', :other => '%{count} dias'},
        :about_x_months => {:one => 'aprox. 1 mes', :other => 'aprox. %{count} meses'},
        :x_months => {:one => '1 mês', :other => '%{count} meses'},
        :about_x_years => {:one => 'aprox. 1 año', :other => 'aprox. %{count} años'},
        :over_x_years => {:one => 'más de 1 año', :other => 'más de %{count} años'},
        :almost_x_years => {:one => 'casi 1 año', :other => 'casi %{count} años'},
      },
      :prompts => {:year => "Año", :month => "Mes", :day => "Día", :hour => "Hora", :minute => "Minuto" ,:second => "Segundo"}
    },
    :half_a_minute => 'Hace medio minuto',
    :less_than_x_seconds => {:one => 'Hace menos de 1 segundo', :other => 'Hace menos de %{count} segundos'},
    :x_seconds => {:one => 'Hace 1 segundo', :other => 'Hace %{count} segundos'},
    :less_than_x_minutes => {:one => 'Hace menos de un minuto', :other => 'Hace menos de %{count} minutos'},
    :x_minutes => {:one => 'Hace 1 minuto', :other => 'Hace %{count} minutos'},
    :about_x_hours => {:one => 'Hace aprox. 1 hora', :other => 'Hace aprox. %{count} horas'},
    :x_days => {:one => 'Hace 1 dia', :other => 'Hace %{count} dias'},
    :about_x_months => {:one => 'Hace aprox. 1 mes', :other => 'Hace aprox. %{count} meses'},
    :x_months => {:one => 'Hace 1 mês', :other => 'Hace %{count} meses'},
    :about_x_years => {:one => 'Hace aprox. 1 año', :other => 'Hace aprox. %{count} años'},
    :over_x_years => {:one => 'Hace más de 1 año', :other => 'Hace más de %{count} años'},
    :almost_x_years => {:one => 'Hace casi 1 año', :other => 'Hace casi %{count} años'},

    :helpers => {
      :select => {:prompt => "Por favor seleccione"},
      :submit => {:create => 'Crear %{model}', :update => 'Actualizar %{model}', :submit => 'Guardar %{model}'}
    },
    
    :errors => {
      :format => "%{attribute} %{message}",  
      :template => {
        :header => {:one => "No fue posible guardar %{model}: 1 error", :other => "No fue posible guardar %{model}: %{count} errores."},
        :body => "Por favor, verifíque el(los) siguiente(s) campo(s):"
      }
    },

    :activerecord => {
      :errors => {
        :template => {
          :header => {:one =>  "No fue posible guardar %{model}: 1 error", :other =>  "No fue posible guardar %{model}: %{count} errores."},
          :body =>  "Por favor, verifíque el(los) siguiente(s) campo(s):"
        },
        :messages => {
          :taken =>  "ya está en uso",
          :record_invalid =>  "La validación falló: %{errors}",
          :inclusion =>  "no está incluído en la lista",
          :exclusion =>  "no está disponible",
          :invalid =>  "no es válido",
          :confirmation =>  "no está de acuerdo con la confirmación",
          :accepted =>  "debe ser aceptado",
          :empty =>  "no puede quedar vacío",
          :blank =>  "no puede quedar en blanco",
          :too_long =>  "Es muy largo (máximo: %{count} caracteres)",
          :too_short =>  "Es muy corto (mínimo: %{count} caracteres)",
          :wrong_length =>  "no posee el tamaño esperado (%{count} caracteres)",
          :not_a_number =>  "no es un número",
          :not_an_integer =>  "no es un número entero",
          :greater_than =>  "debe ser mayor que %{count}",
          :greater_than_or_equal_to =>  "debe ser mayor o igual a %{count}",
          :equal_to =>  "debe ser igual a %{count}",
          :less_than =>  "debe ser menor que %{count}",
          :less_than_or_equal_to =>  "debe ser menor o igual a %{count}",
          :odd =>  "debe ser impar",
          :even =>  "debe ser par",
        },
        :full_messages => {:format =>  "%{attribute} %{message}"}
      }
    },
    :will_paginate => {
      :previous_label => "« Anterior",
      :next_label => "Siguiente »",
      :page_gap => " ... "
    }
    
  }
}
